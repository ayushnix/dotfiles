if exists("b:current_syntax")
    unlet b:current_syntax
endif
syntax include @yamlTop syntax/yaml.vim
syntax region yamlFrontMatter start=/\%^---$/ end=/^---$/ keepend contains=@yamlTop
