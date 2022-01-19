if exists("b:current_syntax")
    unlet b:current_syntax
endif
syntax include @yamlTop syntax/yaml.vim
syntax region yamlFrontMatter start=/\%^---$/ end=/^---$/ keepend contains=@yamlTop
syntax include @tomlTop syntax/toml.vim
syntax region tomlFrontMatter start=/\%^+++$/ end=/^+++$/ keepend contains=@tomlTop
