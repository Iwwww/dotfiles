#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wayland-client.h>

#include "river-status-unstable-v1-client-protocol.h"

struct app;

struct output_state {
    struct app *app;
    struct wl_output *output;
    struct zriver_output_status_v1 *status;
    uint32_t registry_name;
    uint32_t focused_mask;
    uint32_t occupied_mask;
    uint32_t urgent_mask;
    struct output_state *next;
};

struct app {
    struct wl_display *display;
    struct wl_registry *registry;
    struct zriver_status_manager_v1 *manager;
    struct output_state *outputs;
    bool ready;
};

static void emit_tags(const struct app *app) {
    uint32_t focused = 0;
    uint32_t occupied = 0;
    uint32_t urgent = 0;
    bool first = true;

    for (const struct output_state *output = app->outputs; output != NULL; output = output->next) {
        focused |= output->focused_mask;
        occupied |= output->occupied_mask;
        urgent |= output->urgent_mask;
    }

    fputc('[', stdout);
    for (uint32_t tag = 1; tag <= 20; tag++) {
        uint32_t bit = 1u << (tag - 1);
        if ((focused & bit) == 0 && (occupied & bit) == 0 && (urgent & bit) == 0) {
            continue;
        }

        if (!first) {
            fputc(',', stdout);
        }
        first = false;

        fprintf(stdout, "{\"id\":\"%u\",\"class\":\"tag", tag);
        if ((focused & bit) != 0) {
            fputs(" focused", stdout);
        }
        if ((occupied & bit) != 0) {
            fputs(" occupied", stdout);
        }
        if ((urgent & bit) != 0) {
            fputs(" urgent", stdout);
        }
        fputs("\"}", stdout);
    }
    fputs("]\n", stdout);
    fflush(stdout);
}

static uint32_t decode_view_tags(const struct wl_array *tags) {
    const uint8_t *bytes = tags->data;
    uint32_t occupied = 0;

    for (size_t offset = 0; offset + 3 < tags->size; offset += 4) {
        uint32_t mask = ((uint32_t)bytes[offset])
            | ((uint32_t)bytes[offset + 1] << 8)
            | ((uint32_t)bytes[offset + 2] << 16)
            | ((uint32_t)bytes[offset + 3] << 24);
        occupied |= mask;
    }

    return occupied;
}

static void handle_focused_tags(void *data, struct zriver_output_status_v1 *status, uint32_t tags) {
    (void)status;
    struct output_state *output = data;
    output->focused_mask = tags;
    if (output->app->ready) {
        emit_tags(output->app);
    }
}

static void handle_view_tags(void *data, struct zriver_output_status_v1 *status, struct wl_array *tags) {
    (void)status;
    struct output_state *output = data;
    output->occupied_mask = decode_view_tags(tags);
    if (output->app->ready) {
        emit_tags(output->app);
    }
}

static void handle_urgent_tags(void *data, struct zriver_output_status_v1 *status, uint32_t tags) {
    (void)status;
    struct output_state *output = data;
    output->urgent_mask = tags;
    if (output->app->ready) {
        emit_tags(output->app);
    }
}

static void handle_layout_name(void *data, struct zriver_output_status_v1 *status, const char *name) {
    (void)data;
    (void)status;
    (void)name;
}

static void handle_layout_name_clear(void *data, struct zriver_output_status_v1 *status) {
    (void)data;
    (void)status;
}

static const struct zriver_output_status_v1_listener output_status_listener = {
    .focused_tags = handle_focused_tags,
    .view_tags = handle_view_tags,
    .urgent_tags = handle_urgent_tags,
    .layout_name = handle_layout_name,
    .layout_name_clear = handle_layout_name_clear,
};

static void attach_output_status(struct output_state *output) {
    if (output->app->manager == NULL || output->status != NULL) {
        return;
    }

    output->status = zriver_status_manager_v1_get_river_output_status(output->app->manager, output->output);
    zriver_output_status_v1_add_listener(output->status, &output_status_listener, output);
}

static void destroy_output(struct output_state *output) {
    if (output->status != NULL) {
        zriver_output_status_v1_destroy(output->status);
    }
    if (output->output != NULL) {
        wl_output_destroy(output->output);
    }
    free(output);
}

static void handle_global(void *data, struct wl_registry *registry, uint32_t name, const char *interface, uint32_t version) {
    (void)version;
    struct app *app = data;

    if (strcmp(interface, zriver_status_manager_v1_interface.name) == 0) {
        app->manager = wl_registry_bind(registry, name, &zriver_status_manager_v1_interface, 4);
        for (struct output_state *output = app->outputs; output != NULL; output = output->next) {
            attach_output_status(output);
        }
        return;
    }

    if (strcmp(interface, wl_output_interface.name) == 0) {
        struct output_state *output = calloc(1, sizeof(*output));
        if (output == NULL) {
            fprintf(stderr, "river-tag-state: out of memory\n");
            exit(1);
        }
        output->app = app;
        output->registry_name = name;
        output->output = wl_registry_bind(registry, name, &wl_output_interface, 1);
        output->next = app->outputs;
        app->outputs = output;
        attach_output_status(output);
    }
}

static void handle_global_remove(void *data, struct wl_registry *registry, uint32_t name) {
    (void)registry;
    struct app *app = data;
    struct output_state **current = &app->outputs;

    while (*current != NULL) {
        if ((*current)->registry_name == name) {
            struct output_state *removed = *current;
            *current = removed->next;
            destroy_output(removed);
            if (app->ready) {
                emit_tags(app);
            }
            return;
        }
        current = &(*current)->next;
    }
}

static const struct wl_registry_listener registry_listener = {
    .global = handle_global,
    .global_remove = handle_global_remove,
};

int main(void) {
    struct app app = {0};

    setvbuf(stdout, NULL, _IOLBF, 0);

    app.display = wl_display_connect(NULL);
    if (app.display == NULL) {
        fprintf(stderr, "river-tag-state: failed to connect to Wayland display\n");
        return 1;
    }

    app.registry = wl_display_get_registry(app.display);
    wl_registry_add_listener(app.registry, &registry_listener, &app);

    if (wl_display_roundtrip(app.display) == -1) {
        fprintf(stderr, "river-tag-state: failed to read Wayland globals\n");
        return 1;
    }
    if (app.manager == NULL) {
        fprintf(stderr, "river-tag-state: river status manager is unavailable\n");
        return 1;
    }
    if (wl_display_roundtrip(app.display) == -1) {
        fprintf(stderr, "river-tag-state: failed to read initial River state\n");
        return 1;
    }

    app.ready = true;
    emit_tags(&app);

    while (wl_display_dispatch(app.display) != -1) {
    }

    return 0;
}
