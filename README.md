# Sistema de Gerenciamento de Empresa

Bem-vindo ao repositório do Sistema de Gerenciamento de Empresa! Este projeto consiste em um esquema de banco de dados SQL para uma empresa, abrangendo informações sobre funcionários, departamentos, projetos e suas interações. Este README irá guiá-lo através da estrutura do banco de dados e oferecer insights sobre como usar e expandir este sistema.

## Estrutura do Banco de Dados

O banco de dados é composto por várias tabelas que se relacionam para armazenar informações sobre funcionários, departamentos, projetos e seus detalhes. Aqui está uma visão geral das tabelas principais:

- **employee**: Armazena detalhes dos funcionários, como nome, sexo, salário e departamento associado.
- **department**: Mantém informações sobre os departamentos, incluindo nome, número e gerente responsável.
- **dept_locations**: Registra as localizações dos departamentos.
- **project**: Armazena detalhes dos projetos, como nome, número, localização e departamento associado.
- **work_on**: Rastreia a alocação de funcionários em projetos específicos, registrando as horas dedicadas.
- **dependent**: Mantém informações sobre dependentes dos funcionários.

## Como Usar

1. **Clone o Repositório**: Comece clonando este repositório para o seu ambiente local:

   ```
   git clone https://github.com/franciscorigon/DB_Regular_Company.git
   ```

2. **Configure o Banco de Dados**: Execute as consultas SQL presentes nos arquivos `create_tables.sql` e `insert_data.sql` para criar as tabelas e inserir dados iniciais.

3. **Explorando as Consultas**: Utilize o arquivo `queries.sql` para explorar consultas básicas para recuperar informações sobre funcionários, departamentos, projetos e muito mais.

4. **Consulta Avançadas**: À medida que você se familiariza com o sistema, sinta-se à vontade para adicionar consultas mais avançadas e personalizadas ao arquivo `queries.sql`.

5. **Expansão do Sistema**: Se você deseja expandir este sistema, adicione novas tabelas, consultas avançadas ou restrições complexas. Lembre-se de atualizar este README conforme você adiciona novos componentes.

## Exemplos de Consultas

Aqui estão alguns exemplos básicos de consultas que você pode executar no sistema:

1. Recuperar todos os funcionários de um departamento específico:

   ```sql
   SELECT * FROM employee WHERE Dno = 1;
   ```

2. Encontrar projetos em que um funcionário específico está trabalhando:

   ```sql
   SELECT Pname FROM project
   WHERE Pnumber IN (SELECT Pno FROM work_on WHERE Essn = '123456789');
   ```

3. Calcular o salário médio por sexo:

   ```sql
   SELECT Sex, AVG(Salary) AS AvgSalary FROM employee GROUP BY Sex;
   ```

## Contribuição

Este é um projeto em constante evolução, e sua contribuição é bem-vinda! Sinta-se à vontade para abrir problemas, enviar solicitações pull ou adicionar mais recursos ao sistema.

Divirta-se explorando e expandindo o Sistema de Gerenciamento de Empresa! Se tiver alguma dúvida ou precisar de assistência, não hesite em entrar em contato.

**Contato:** LinkedIn.com/franciscorigon

⭐️ Se este projeto foi útil para você, não deixe de dar uma estrela!

--- 
