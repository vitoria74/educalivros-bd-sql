# educalivros-bd-sql

Projeto para uma Escola-Livraria online chamada EducaLivros.

## Definição
A EducaLivros é uma livraria online especializada em vender livros, jogos de tabuleiro e material escolar, como bolsas e cadernos, para alunos, professores e clientes externos. Também oferecemos planos para os usuários que quiserem receber descontos em suas compras. Além disso, o site oferece a opção "Avaliação", onde os usuários podem avaliar os produtos que compraram, com notas e/ou comentários e ainda receber seus pedidos em casa, com a opção "Entrega".

## Alunos:
- Vitória Moura Paiva
- Luiz Cláudio Brito
- Gabriel Reis Batista

## Tecnologias Usadas:
- Prisma
- Docker
- PostgreSQL

## O que foi implementado?
- CRUD: Adicionamos mais 3 tabelas (AudioBook, Ebook e Jogos Tabuleiro), fizemos 3 SELECTS (AudioBook, Ebook e Jogos Tabuleiro), 3 UPDATES (UpdateUsuario, UpdateProfessor e UpdateLivro) e 3 DELETES (DeleteUsuario, DeleteProfessor e DeleteLivro)
- Triggers (atualizar_Estoque, atualizar_recomendacao)
- Views (autor_vendas_recomendacao, livro_resumo)
- Stored Procedures (atualizar_Estoque, atualizar_recomendacao)
- Segurança (usuario_comum_aluno, professor_admin)
- Normalização Exemplos detalhados:
- 
![Captura de tela 2024-06-14 211214](https://github.com/vitoria74/educalivros-bd-sql/assets/99884688/1b7f0ce1-9fb7-4fda-a84b-933010702309)

![Captura de tela 2024-06-14 211154](https://github.com/vitoria74/educalivros-bd-sql/assets/99884688/e53b74a8-8940-4035-ab29-b606e3ff8d96)

![Captura de tela 2024-06-14 211235](https://github.com/vitoria74/educalivros-bd-sql/assets/99884688/618c4c6c-b0b3-45e5-845c-0602ae4071a8)

![Captura de tela 2024-06-14 211256](https://github.com/vitoria74/educalivros-bd-sql/assets/99884688/9acbaded-f9d4-4c82-a743-07d8e3af03c4) 

![Captura de tela 2024-06-14 211320](https://github.com/vitoria74/educalivros-bd-sql/assets/99884688/e08ab91c-7cb2-48fb-aef7-416108e77476)


## O projeto no Docker![Uploading Captura de tela 2024-06-14 211320.png…]()

![WhatsApp Image 2024-06-12 at 7 49 57 PM](https://github.com/vitoria74/educalivros-bd-sql/assets/105817834/657fc2b6-d31d-4816-add9-ee4472a280a7)
![WhatsApp Image 2024-06-12 at 7 51 33 PM](https://github.com/vitoria74/educalivros-bd-sql/assets/105817834/b310cf11-5ed1-438b-ae82-4dbcbf217840)

