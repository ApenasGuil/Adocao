# AdoCão

AdoCão é uma plataforma de doação de pets (cachorros, gatos, pássaros, etc.), permitindo que usuários anunciem animais disponíveis para adoção.
Os usuários podem adicionar detalhes sobre o pet e imagens, e a plataforma apresenta uma lista de pets disponíveis para adoção baseada na proximidade da localização do usuário (bairro e cidade).

## Funcionalidades

### Usuário:

- Cadastro de usuário:
  - Nome,
  - Email,
  - Senha,
  - Bairro e cidade
  - Imagem de perfil
- Login e logout de usuários autenticados.
- Perfil de usuário que inclui suas informações e pets cadastrados.
- Cadastro de pets para doação com as seguintes informações:
  - Nome do pet,
  - Sexo,
  - Idade aproximada,a
  - Raça (opcional),
  - Imagens (mínimo 1, máximo 3)
- Listagem dos pets disponíveis na plataforma

## Tecnologias Utilizadas

### Frontend:

- ReactJS
- TailwindCSS, PostCSS e Autoprefixer
- Lucide (Ícones)
- Axios (Requisições HTTP)
- React Router DOM (Gerenciamento de rotas)

### Backend:

- Node.js com Express.js
- Autenticação de usuários
- MySQL

## Instalação e Uso

### Pré-requisitos:

- Node.js (v20.16.0)
- MySQL (v8.0.30)

### Passos para rodar o projeto:

1. Clone o repositório:

   ```bash
   git clone https://github.com/ApenasGuil/Adocao
   ```

2. Prompt 1

   ```bash
   cd adocao/backend
   npm run dev
   http://localhost:3001/server-test
   ```

3. Prompt 2
   ```bash
   cd adocao/frontend
   npm run dev
   http://localhost:5173/
   ```

### Figma

https://www.figma.com/proto/yCuVP6UII1TL8IajOzPUYU/AdoCão?node-id=9-10&node-type=canvas&t=UOWdD9hrf66k1M6G-0&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=9%3A10
