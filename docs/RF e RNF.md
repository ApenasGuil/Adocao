### Requisitos Funcionais

####  RF-01: Cadastro de Usuário
O sistema deve permitir que os usuários façam cadastro informando nome, email, senha e imagem de perfil e localização (bairro e cidade para busca).
O email deve ser único e validado antes do cadastro.

#### RF-02: Login de Usuário
O sistema deve permitir que os usuários façam login com email e senha.
O login deve gerar um token JWT para sessões autenticadas.

#### RF-03: Logout de Usuário
O sistema deve permitir que o usuário autenticado faça logout, invalidando o token de sessão.

#### RF-04: Cadastro de Pets
O usuário autenticado deve poder cadastrar um pet para doação, informando os seguintes dados:
- Nome do pet
- Sexo (M/F)
- Idade aproximada
- Raça (opcional)
- Imagens (mínimo 1 e no máximo 3)
  
`O cadastro de pets deve permitir o upload das imagens e armazená-las corretamente no servidor ou em serviço de armazenamento de arquivos (ex: AWS S3).`

#### RF-05: Listagem de Pets
A página inicial deve exibir uma lista de pets disponíveis para adoção em layout responsivo.

#### RF-06: Visualização de Detalhes do Pet
O usuário deve poder clicar em um pet listado na página inicial para visualizar mais detalhes sobre ele, como nome, raça, idade, sexo e imagens.

#### RF-07: Validação de Formulários
Todos os formulários (cadastro de usuário e cadastro de pet) devem ser validados no frontend e backend, verificando campos obrigatórios e formatos válidos.

#### RF-08: Perfis de Usuário
O usuário autenticado deve ter uma página de perfil onde pode visualizar suas informações e os pets que cadastrou para doação, podendo informar os que já não estão mais para doação.

#### RF-09: Edição de Perfil e Senha
O sistema deve permitir que o usuário edite suas informações pessoais, incluindo nome, email, senha e imagem de perfil. A senha pode ser alterada mediante confirmação da senha atual.

### Requisitos Não Funcionais

#### RNF-01: Autenticação Segura
A autenticação deve utilizar JWT e as senhas dos usuários devem ser armazenadas no banco de dados utilizando hashing seguro (ex: bcrypt).

#### RNF-02: Segurança de Dados
As imagens de perfil e dos pets devem ser armazenadas de forma segura, com permissões adequadas para garantir a privacidade dos arquivos.

#### RNF-03: Desempenho
O tempo de resposta das páginas deve ser rápido, com carregamento total em até 3 segundos em uma conexão comum.
A aplicação deve suportar pelo menos 100 usuários simultâneos sem degradação significativa de desempenho.

#### RNF-04: Escalabilidade

A arquitetura do sistema deve permitir escalabilidade horizontal, ou seja, novos servidores podem ser adicionados para suportar um aumento no número de usuários e dados.

#### RNF-05: Responsividade

O frontend deve ser totalmente responsivo, adaptando-se a diferentes tamanhos de tela (celulares, tablets, desktops).

#### RNF-06: Compatibilidade de Navegadores
A aplicação deve ser compatível com os navegadores modernos, como Google Chrome, Firefox, Safari e Microsoft Edge.

#### RNF-07: Manutenção
O código do sistema deve ser modular e fácil de manter, com testes automatizados cobrindo as principais funcionalidades (ex: testes de unidade e integração).