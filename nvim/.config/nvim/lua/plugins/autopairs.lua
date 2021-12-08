local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    map_c_w = true -- map <c-w> to delete a pair if possible
})

npairs.add_rule()
npairs.add_rules({
    -- JS arrow function
    Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
        :use_regex(true)
        :set_end_pair_length(2),
    Rule("{/*","*/", { "javascript", "typescript", "typescriptreact" })
})
