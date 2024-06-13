async function createAutor() {
  const novoAutor = await prisma.autor.create({
    data: {
      p_nome: 'João',
      s_nome: 'Silva',
      numero_de_vendas: 10,
      codigo: 'A001',
      Recomendação: 5
    },
  });
  console.log('Autor criado:', novoAutor);
}

createAutor().catch(e => console.error(e)).finally(async () => {
  await prisma.$disconnect();
});
 

async function getAutorByCodigo(codigo) {
  const autor = await prisma.autor.findUnique({
    where: { codigo: codigo },
  });
  console.log('Autor encontrado:', autor);
}

getAutorByCodigo('A001').catch(e => console.error(e)).finally(async () => {
  await prisma.$disconnect();
});
 
async function getAllAutores() {
  const autores = await prisma.autor.findMany();
  console.log('Todos os autores:', autores);
}

getAllAutores().catch(e => console.error(e)).finally(async () => {
  await prisma.$disconnect();
});
 

async function updateAutor(codigo, numeroDeVendas, recomendacao) {
  const autorAtualizado = await prisma.autor.update({
    where: { codigo: codigo },
    data: {
      numero_de_vendas: numeroDeVendas,
      Recomendação: recomendacao,
    },
  });
  console.log('Autor atualizado:', autorAtualizado);
}

updateAutor('A001', 15, 7).catch(e => console.error(e)).finally(async () => {
  await prisma.$disconnect();
});
 

async function deleteAutor(codigo) {
  const autorExcluido = await prisma.autor.delete({
    where: { codigo: codigo },
  });
  console.log('Autor excluído:', autorExcluido);
}

deleteAutor('A001').catch(e => console.error(e)).finally(async () => {
  await prisma.$disconnect();
});
