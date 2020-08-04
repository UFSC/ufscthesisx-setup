# ufscthesisx

Esta é uma classe LaTeX.

O modelo disponibilizado pela Biblioteca Universitária da UFSC em 2015,
utiliza a `abntex` versão `0.8.2`, considerada muito antiga,
portanto tratou-se de buscar a criação deste novo modelo que utiliza a classe `abntex2` versão `1.9.6`.

Esse projeto não está vinculado a nenhum órgão da UFSC.

Qualquer problema com a utilização ou com o modelo em si,
basta criar um issue aqui no GitHub no nosso issue tracker: [issues](../../issues)


### Utilizando `git`

No diretório do seu projeto faça um clone (recursivo) dos arquivos do repositório,
em uma pasta chamada `setup` dentro do template da sua tese:
```bash
git clone --recursive https://github.com/ufsc/ufscthesisx-setup setup
```

Para usá-lo,
você deve utilizar a classe `setup/ufscthesisx` como classe do seu documento,
e então incluir onde está são os arquivos de sua bibliografia:
```latex
% Uncomment the following line if you want to use other biblatex settings
% \PassOptionsToPackage{style=numeric,repeatfields=true,backend=biber,backref=true,citecounter=true}{biblatex}
\documentclass[
\lang{english}{brazilian,brazil},
12pt, % Padrão UFSC para versão final
a4paper, % Padrão UFSC para versão final
twoside, % Impressão nos dois lados da folha
chapter=TITLE, % Título de capítulos em caixa alta
section=TITLE, % Título de seções em caixa alta
]{setup/ufscthesisx}

% Utilize o arquivo aftertext/references.bib para incluir sua bibliografia.
% http://tug.ctan.org/tex-archive/macros/latex/contrib/cleveref/cleveref.pdf
\addbibresource{aftertext/references.bib}
```

Uma maneira  de utilizar esse **template**,
caso você seja usuário de `git`,
é fazer o clone desse repositório como um submodulo de sua tese,
e em seu arquivo principal incluir o seguinte cabeçalho para carregar os pacotes básicos mencionados acima.


### Mudanças

Para ver as mudanças, acesse o histórico do `git` no endereço [commits/master](../../commits/master).

Ou clone este repositório e execute seguinte comando do cliente git:
```bash
# https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History
git log
```


## Compilação

O jeito mais legal de compilar é executando um dos seguintes comandos:
1. **`make clean`**
1. **`make clean halt=1 debug=1`**
1. **`make latex biber latex1`**
1. **`make latex biber latex1 halt=1 debug=1`**
1. **`make latex biber latex1 biber1 latex2`**
1. **`make latex biber latex1 biber1 latex2 halt=1 debug=1`**
1. **`...`**

Se você quiser saber quais são todos os comandos de compilação disponíveis,
basta chamar utilizar o comando `make help`. Exemplo:
```
$ make help

 Usage:
   make <target> [debug=1]

 Use debug=1 to run make in debug mode. Use this if something does not work!
 Examples:
   make help
   make debug=1
   make latex debug=1
   make thesis debug=1

...
```

Caso você tenha problemas,
erros ou algo não funcione,
execute o make file em modo debug.
Para isso,
basta chamar ele como você normalmente faz,
mas passando o parâmetro `debug=true`.
Por exemplo,
`make latex debug=true`.

Por conveniência,
você também pode chamar `make latex debug=1` qualquer outra coisa desde que não seja vazio.
Você também pode diretamente editar o arquivo `setup/makefile.mk` e
descomentar a linha `# ENABLE_DEBUG_MODE := true` para ativar o modo debug permanentemente.


## Licença

```
Copyright (c) 2012-2014 by abnTeX2 group at http://abntex2.googlecode.com/
Copyright (c) 2014-2015 Mateus Dubiela Oliveira
Copyright (c) 2015-2016 Adriano Ruseler
Copyright (c) 2017-2018 Evandro Coan, Luiz Rafael dos Santos
Copyright (c) 2019-2019 Alisson Lopes Furlani

É concedida permissão, gratuitamente, a qualquer pessoa que obtenha uma cópia deste modelo e
software e arquivos de documentação associados (o "Software"), para ter estes arquivos com os
direitos de uso, cópia, modificação, mesclagem, publicar, distribuir, e permitir que as pessoas a
quem o Software seja fornecido tenham estes mesmos direitos, ambos sujeitos às seguintes condições:

O aviso de direitos autorais acima e este aviso de permissão devem ser incluídos em todas as cópias
ou partes substanciais do Software.

Os arquivos `chapters/intro.tex`, `chapters/chapter_1.tex` e `setup/ufscthesisx.sty` estão
licenciados sobre a licença LPPL (The Latex Project License). Portanto você deve respeitar essa
licença para esses arquivos ao invés dessa. Entretanto a condição a seguir continuará valendo sobre
esses arquivos licenciados pela licença LPPL:

OS ARQUIVOS NESTE REPOSITÓRIO SÃO FORNECIDOS "NO ESTADO EM QUE SE ENCONTRAM", SEM GARANTIA DE
QUALQUER TIPO, EXPRESSA OU IMPLÍCITA, INCLUINDO, MAS NÃO SE LIMITANDO ÀS GARANTIAS DE
COMERCIALIZAÇÃO, APTIDÃO PARA UM PROPÓSITO ESPECÍFICO E NÃO INFRACÇÃO. EM NENHUMA CIRCUNSTÂNCIA, OS
AUTORES OU TITULARES DE DIREITOS AUTORAIS SERÃO RESPONSÁVEIS POR QUALQUER RECLAMAÇÃO, DANOS OU OUTRA
RESPONSABILIDADE, SEJA EM AÇÃO DE CONTRATO, DELITO OU DE OUTRA FORMA, DECORRENTE, DESTE OU
RELACIONADO COM DOS ARQUIVOS DESTE REPOSITÓRIO OU O USO OU OUTRAS NEGOCIAÇÕES NO MODELO E SOFTWARE.
```

