# AdoCão

AdoCão é uma plataforma de doação de pets (cachorros, gatos, pássaros, etc.), permitindo que usuários anunciem animais disponíveis para adoção.
Os usuários podem adicionar detalhes sobre o pet e imagens, e a plataforma apresenta uma lista de pets disponíveis para adoção baseada na proximidade da localização do usuário (bairro e cidade).

## Requisitos Funcionais

### RF-01: Cadastro de Usuário

O sistema deve permitir que os usuários façam cadastro informando nome, email, senha, número celular e imagem de perfil e localização (bairro e cidade para busca).
O email deve ser único e validado antes do cadastro.

#### RF-01.1: Validação de dados

O sistema deve validar se o e-mail informado é único no banco de dados.
O sistema deve garantir que a senha tenha no mínimo 8 caracteres.

#### RF-01.2: Confirmação de cadastro

O sistema deve enviar um e-mail de confirmação para o usuário após o cadastro.
O sistema deve ativar o usuário apenas após a confirmação do e-mail.

#### RF-01.3: Campos obrigatórios

O sistema deve exigir que os campos nome completo, e-mail, senha, cidade e bairro sejam preenchidos.

#### RF-01.4: Mensagens de erro

O sistema deve exibir mensagens de erro caso algum campo obrigatório não seja preenchido ou caso as senhas não coincidam.

### RF-02: Edição de Usuário

O sistema deve permitir que o usuário autenticado edite seu próprio perfil.
A alteração de e-mail deve ser feita sob confirmação, através de link, no e-mail atual.

#### RF-02.1: Atualização de senha

O sistema deve permitir que o usuário altere sua senha, solicitando a senha atual e a nova senha.

#### RF-02.2: Validação de alterações

O sistema deve validar as alterações realizadas e garantir que todos os campos obrigatórios estejam preenchidos corretamente.

### RF-03: Exclusão de Usuário

O sistema deve permitir que o usuário exclua sua conta.

#### RF-03.1: Confirmação de exclusão

O sistema deve solicitar confirmação via e-mail. Após confirmação, a coluna "is_deleted" será setada como true
Os pets, que ainda estiverem disponíveis e vinculados a conta excluída, também devem ter sua coluna "is_deleted" como true.

#### RF-03.2: Remoção de dados

O sistema não removerá os dados do usuário, apenas desabilitará a conta.
Caso o usuário queira criar uma nova conta com o mesmo e-mail, os dados serão sobrescritos.

### RF-03: Login de Usuário

O sistema deve permitir que os usuários façam login com email e senha.
O login deve gerar um token JWT para sessões autenticadas.

#### RF-03.1: Validação de credenciais

O sistema deve validar o e-mail e a senha informados.

#### RF-03.2: Tratamento de erro

O sistema deve exibir uma mensagem de erro caso o e-mail ou a senha estejam incorretos.

### RF-04: Redefinição de senha

O sistema deve permitir que o usuário, em caso de esquecimento, redefina sua senha a partir da tela de login.

#### RF-04.1: Solicitação de redefinição de senha

O sistema deve disponibilizar um link "Esqueci minha senha" na tela de login.
O sistema deve permitir que o usuário informe seu e-mail registrado para receber instruções de redefinição de senha.

#### RF-04.2: Envio de e-mail para redefinição

O sistema deve enviar um e-mail contendo um link de redefinição de senha para o e-mail informado pelo usuário.
O link de redefinição deve ser único e expirar após um determinado tempo (por exemplo, 24 horas).

#### RF-04.3: Página de redefinição de senha

O sistema deve redirecionar o usuário para uma página onde ele possa inserir uma nova senha, após clicar no link recebido por e-mail.
O sistema deve solicitar a confirmação da nova senha.

#### RF-04.4: Atualização da senha

O sistema deve validar se a nova senha atende aos critérios de segurança (por exemplo, mínimo de 8 caracteres, letras maiúsculas, números, etc.).
O sistema deve salvar a nova senha no banco de dados após a confirmação e redirecionar o usuário para a página de login.

### RF-05: Logout de Usuário

O sistema deve permitir que o usuário autenticado faça logout, invalidando o token de sessão.

#### RF-05.1: Encerramento de sessão

O sistema deve encerrar a sessão ativa do usuário e redirecioná-lo para a página de login.

### RF-06: Cadastro de Pets

O usuário autenticado deve poder cadastrar pets para doação, sem número máximo, informando os seguintes dados:

- Nome do pet
- Categoria (Cachorro, Gato, Pássaro, Outro)
- Sexo (M/F)
- Idade (Aproximado)
- Motivo da adoção
- Descrição da personalidade (Humor: agitado, brincalhão, carinhoso)
- Temperamento (Escala de dócil de 0 à 5, sendo 0: agressivo e 5: super dócil)
- Socialização com pessoas (Escala de 0 à 5, sendo 0: pouco e 5: tranquilo)
- Socialização com outros animais (Escala de 0 à 5, sendo 0: nunca houve e 5: muito sociável)
- Ambiente ideal (Casa/Apartamento, espaço para correr, gaiola grande)
- Necessidades (Cuidados especiais: tapetinho para urina, vitaminas)
- Imagens (mínimo 1 e no máximo 3)
- Microchip (Caso tenha, informações do mesmo)
- Itens (Opcional: brinquedos, potes, ração, gaiola, caminha, casinha, caixa de transporte)
- Vacinação e saúde (Opcional)
- Histórico de doenças (Opcional)
- Raça (Opcional)

`O cadastro de pets deve permitir o upload das imagens e armazená-las corretamente no servidor ou em serviço de armazenamento de arquivos (ex: AWS S3).`

### RF-07: Edição de Pets

O sistema deve permitir que o usuário edite as informações dos pets inseridos por ele e que ainda estejam disponíveis.

### RF-08: Exclusão de Pets

O sistema deve permitir que o usuário sinalize os pets que já não estiverem mais disponíveis para adoção, removendo de pesquisas e da listagem principal. E o realocar em uma listagem de pets doados, para relatórios futuros.

### RF-09: Listagem de Pets

A página inicial deve exibir uma lista com nome e foto e nome do tutor, dos pets disponíveis para adoção, em forma de cards e layout responsivo.

#### RF-09.1: Filtragem de Pets

O sistema deve permitir que o usuário filtre os pets por categoria, bairro/cidade ou data da adição (crescente ou decrescente).

### RF-10: Visualização de Detalhes do Pet

O usuário deve poder clicar em um pet listado na página inicial para visualizar mais detalhes sobre ele, como nome, raça, idade, sexo e imagens.

### RF-11: Validação de Formulários

Todos os formulários (cadastro de usuário e cadastro de pet) devem ser validados no frontend e backend, verificando campos obrigatórios e formatos válidos.

### RF-12: Perfis de Usuário

O usuário autenticado deve ter uma página de perfil onde pode visualizar suas informações e os pets que cadastrou para doação, podendo informar os que já não estão mais para doação.

### RF-13: Edição de Perfil e Senha

O sistema deve permitir que o usuário edite suas informações pessoais, incluindo nome, email, senha e imagem de perfil. A senha pode ser alterada mediante confirmação da senha atual.

### RF-14: Propaganda

O sistema deve ter uma seção para banner de divulgação de propaganda de petshop, perceiro ou patrocinador, com um link levando ao site do mesmo.

## Requisitos Não Funcionais

### RNF-01: Autenticação Segura

A autenticação deve utilizar JWT e as senhas dos usuários devem ser armazenadas no banco de dados utilizando hashing seguro (ex: bcrypt).

### RNF-02: Segurança de Dados

As imagens de perfil e dos pets devem ser armazenadas de forma segura, com permissões adequadas para garantir a privacidade dos arquivos.

### RNF-03: Desempenho

O tempo de resposta das páginas deve ser rápido, com carregamento total em até 3 segundos em uma conexão comum.
A aplicação deve suportar pelo menos 100 usuários simultâneos sem degradação significativa de desempenho.

### RNF-04: Escalabilidade

A arquitetura do sistema deve permitir escalabilidade horizontal, ou seja, novos servidores podem ser adicionados para suportar um aumento no número de usuários e dados.

### RNF-05: Responsividade

O frontend deve ser totalmente responsivo, adaptando-se a diferentes tamanhos de tela (celulares, tablets, desktops).

### RNF-06: Compatibilidade de Navegadores

A aplicação deve ser compatível com os navegadores modernos, como Google Chrome, OperaGX, Firefox, Safari e Microsoft Edge.

### RNF-07: Manutenção

O código do sistema deve ser modular e fácil de manter, com testes automatizados cobrindo as principais funcionalidades (ex: testes de unidade e integração).
