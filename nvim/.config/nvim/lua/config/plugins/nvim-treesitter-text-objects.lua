local select = function(query, group)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, group or "textobjects")
  end
end

local move = function(fn, query, group)
  return function()
    require("nvim-treesitter-textobjects.move")[fn](query, group or "textobjects")
  end
end

local swap = function(fn, query, group)
  return function()
    require("nvim-treesitter-textobjects.swap")[fn](query, group or "textobjects")
  end
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local keymap = vim.keymap

    -- select
    keymap.set({ "x", "o" }, "a=", select("@assignment.outer"))
    keymap.set({ "x", "o" }, "i=", select("@assignment.inner"))
    keymap.set({ "x", "o" }, "l=", select("@assignment.lhs"))
    keymap.set({ "x", "o" }, "r=", select("@assignment.rhs"))

    -- ecma object properties (custom query in after/queries/ecma/textobjects.scm)
    keymap.set({ "x", "o" }, "a:", select("@property.outer"))
    keymap.set({ "x", "o" }, "i:", select("@property.inner"))
    keymap.set({ "x", "o" }, "l:", select("@property.lhs"))
    keymap.set({ "x", "o" }, "r:", select("@property.rhs"))

    keymap.set({ "x", "o" }, "aa", select("@parameter.outer"))
    keymap.set({ "x", "o" }, "ia", select("@parameter.inner"))

    keymap.set({ "x", "o" }, "ai", select("@conditional.outer"))
    keymap.set({ "x", "o" }, "ii", select("@conditional.inner"))

    keymap.set({ "x", "o" }, "al", select("@loop.outer"))
    keymap.set({ "x", "o" }, "il", select("@loop.inner"))

    keymap.set({ "x", "o" }, "af", select("@call.outer"))
    keymap.set({ "x", "o" }, "if", select("@call.inner"))

    keymap.set({ "x", "o" }, "am", select("@function.outer"))
    keymap.set({ "x", "o" }, "im", select("@function.inner"))

    keymap.set({ "x", "o" }, "ac", select("@class.outer"))
    keymap.set({ "x", "o" }, "ic", select("@class.inner"))

    -- swap
    keymap.set("n", "<leader>na", swap("swap_next", "@parameter.inner"))
    keymap.set("n", "<leader>n:", swap("swap_next", "@property.outer"))
    keymap.set("n", "<leader>nm", swap("swap_next", "@function.outer"))

    keymap.set("n", "<leader>pa", swap("swap_previous", "@parameter.inner"))
    keymap.set("n", "<leader>p:", swap("swap_previous", "@property.outer"))
    keymap.set("n", "<leader>pm", swap("swap_previous", "@function.outer"))

    -- move
    keymap.set({ "n", "x", "o" }, "]f", move("goto_next_start", "@call.outer"))
    keymap.set({ "n", "x", "o" }, "]m", move("goto_next_start", "@function.outer"))
    keymap.set({ "n", "x", "o" }, "]c", move("goto_next_start", "@class.outer"))
    keymap.set({ "n", "x", "o" }, "]i", move("goto_next_start", "@conditional.outer"))
    keymap.set({ "n", "x", "o" }, "]l", move("goto_next_start", "@loop.outer"))
    keymap.set({ "n", "x", "o" }, "]s", move("goto_next_start", "@scope", "locals"))
    keymap.set({ "n", "x", "o" }, "]z", move("goto_next_start", "@fold", "folds"))

    keymap.set({ "n", "x", "o" }, "]F", move("goto_next_end", "@call.outer"))
    keymap.set({ "n", "x", "o" }, "]M", move("goto_next_end", "@function.outer"))
    keymap.set({ "n", "x", "o" }, "]C", move("goto_next_end", "@class.outer"))
    keymap.set({ "n", "x", "o" }, "]I", move("goto_next_end", "@conditional.outer"))
    keymap.set({ "n", "x", "o" }, "]L", move("goto_next_end", "@loop.outer"))

    keymap.set({ "n", "x", "o" }, "[f", move("goto_previous_start", "@call.outer"))
    keymap.set({ "n", "x", "o" }, "[m", move("goto_previous_start", "@function.outer"))
    keymap.set({ "n", "x", "o" }, "[c", move("goto_previous_start", "@class.outer"))
    keymap.set({ "n", "x", "o" }, "[i", move("goto_previous_start", "@conditional.outer"))
    keymap.set({ "n", "x", "o" }, "[l", move("goto_previous_start", "@loop.outer"))

    keymap.set({ "n", "x", "o" }, "[F", move("goto_previous_end", "@call.outer"))
    keymap.set({ "n", "x", "o" }, "[M", move("goto_previous_end", "@function.outer"))
    keymap.set({ "n", "x", "o" }, "[C", move("goto_previous_end", "@class.outer"))
    keymap.set({ "n", "x", "o" }, "[I", move("goto_previous_end", "@conditional.outer"))
    keymap.set({ "n", "x", "o" }, "[L", move("goto_previous_end", "@loop.outer"))

    -- repeatable moves
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
    keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
