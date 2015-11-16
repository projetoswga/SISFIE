create schema SISFIE;

set search_path TO SISFIE;

/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     30/07/2013 17:06:10                          */
/*==============================================================*/


/*==============================================================*/
/* Table: AREA                                                  */
/*==============================================================*/
create table AREA (
   ID_AREA              SERIAL not null,
   DEN_AREA             VARCHAR(255)         not null,
   DESC_AREA            TEXT                 null,
   FLG_ATIVO            BOOL                 null,
   constraint PK_AREA primary key (ID_AREA)
);

/*==============================================================*/
/* Table: AREA_CONHECIMENTO                                     */
/*==============================================================*/
create table AREA_CONHECIMENTO (
   ID_AREA_CONHECIMENTO SERIAL not null,
   DESCRICAO            VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_AREA_CONHECIMENTO primary key (ID_AREA_CONHECIMENTO)
);

/*==============================================================*/
/* Table: AREA_CONHECIMENTO_CURSO                               */
/*==============================================================*/
create table AREA_CONHECIMENTO_CURSO (
   ID_AREA_CONHEC_CURSO SERIAL not null,
   ID_CURSO             INT4                 not null,
   ID_AREA_CONHECIMENTO INT4                 not null,
   constraint PK_AREA_CONHECIMENTO_CURSO primary key (ID_AREA_CONHEC_CURSO)
);

/*==============================================================*/
/* Table: ATUACAO                                               */
/*==============================================================*/
create table ATUACAO (
   ID_ATUACAO           SERIAL not null,
   DSC_ATUACAO          VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_ATUACAO primary key (ID_ATUACAO)
);

/*==============================================================*/
/* Table: ATUACAO_CANDIDATO                                     */
/*==============================================================*/
create table ATUACAO_CANDIDATO (
   ID_ATUACAO_CANDIDATO SERIAL not null,
   ID_CANDIDATO         INT4                 not null,
   ID_ATUACAO           INT4                 not null,
   constraint PK_ATUACAO_CANDIDATO primary key (ID_ATUACAO_CANDIDATO)
);

/*==============================================================*/
/* Table: CAMPO_PREENCHIMENTO                                   */
/*==============================================================*/
create table CAMPO_PREENCHIMENTO (
   ID_CAMPO_PREENCHIMENTO SERIAL not null,
   DSC_CAMPO_PREENCHIMENTO VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_CAMPO_PREENCHIMENTO primary key (ID_CAMPO_PREENCHIMENTO)
);

INSERT INTO campo_preenchimento (ID_CAMPO_PREENCHIMENTO,DSC_CAMPO_PREENCHIMENTO,flg_ativo) VALUES (1,'Dados Bancários',true);
INSERT INTO campo_preenchimento (ID_CAMPO_PREENCHIMENTO,DSC_CAMPO_PREENCHIMENTO,flg_ativo) VALUES (2,'Nível de ensino',true);
INSERT INTO campo_preenchimento (ID_CAMPO_PREENCHIMENTO,DSC_CAMPO_PREENCHIMENTO,flg_ativo) VALUES (3,'Experiência Profissional',true);

SELECT setval('campo_preenchimento_id_campo_preenchimento_seq', 3);

/*==============================================================*/
/* Table: CANDIDATO                                             */
/*==============================================================*/
create table CANDIDATO (
   FLG_TERMO_CONDICAO   BOOL                 null,
   ID_CANDIDATO         SERIAL not null,
   ID_ORGAO_DIVISAO     INT4                 not null,
   ID_MUNICIPIO_ENDERECO INT4                 not null,
   ID_MUNICIPIO_ORGAO   INT4                 not null,
   NOME                 VARCHAR(255)         not null,
   CPF                  VARCHAR(14)          null,
   LOGRADOURO           VARCHAR(255)         null,
   COMPLEMENTO          VARCHAR(255)         null,
   TEL_COMERCIAL        VARCHAR(255)         null,
   TEL_CELULAR          VARCHAR(255)         null,
   TEL_RESIDENCIAL      VARCHAR(255)         null,
   EMAIL_PESSOAL        VARCHAR(255)         null,
   EMAIL_INSTITUCIONAL  VARCHAR(255)         not null,
   SENHA                VARCHAR(255)         null,
   CEP                  VARCHAR(255)         null,
   MATRICULA            VARCHAR(50)          null,
   MATRICULA_CHEFE      VARCHAR(50)          null,
   FLG_NACIONALIDADE_BRASIL BOOL                 not null,
   DOC_ESTRANGEIRO      VARCHAR(255)         null,
   FLG_ATIVO            BOOL                 not null,
   DT_NASCIMENTO        DATE                 null,
   FLG_PRIMEIRO_ACESSO  BOOL                 not null,
   EMAIL_CHEFE          VARCHAR(255)         null,
   PAIS                 VARCHAR(255)         null,
   NOM_EMERGENCIA       VARCHAR(255)         null,
   FLG_NECESSIDADE_ESPECIAL BOOL                 null,
   TEL_EMERGENCIA       VARCHAR(50)          null,
   DESC_NECESSIDADE     VARCHAR(500)         null,
   constraint PK_CANDIDATO primary key (ID_CANDIDATO)
);

/*==============================================================*/
/* Table: CANDIDATO_CARGO                                       */
/*==============================================================*/
create table CANDIDATO_CARGO (
   ID_CANDIDATO_CARGO   SERIAL not null,
   ID_CANDIDATO         INT4                 not null,
   ID_CARGO             INT4                 not null,
   constraint PK_CANDIDATO_CARGO primary key (ID_CANDIDATO_CARGO)
);

/*==============================================================*/
/* Table: CANDIDATO_COMPLEMENTO                                 */
/*==============================================================*/
create table CANDIDATO_COMPLEMENTO (
   ID_CANDIDATO_COMPLEMENTO SERIAL not null,
   ID_CANDIDATO         INT4                 not null,
   NUM_BANCO            VARCHAR(255)         null,
   AG_BANCO             VARCHAR(255)         null,
   CC_BANCO             VARCHAR(255)         null,
   COD_EDUCACIONAL      VARCHAR(255)         null,
   DEN_CURSO_EDUC       VARCHAR(255)         null,
   DEN_INSTITUICAO_EDUC VARCHAR(255)         null,
   DSC_EXPERIENCIA_ATUAL TEXT                 null,
   DSC_EXPERIENCIA_ANTER TEXT                 null,
   constraint PK_CANDIDATO_COMPLEMENTO primary key (ID_CANDIDATO_COMPLEMENTO)
);

/*==============================================================*/
/* Table: CANDIDATO_PREENCHIMENTO                               */
/*==============================================================*/
create table CANDIDATO_PREENCHIMENTO (
   ID_CANDIDADO_PREENCHIMENTO SERIAL not null,
   ID_CURSO             INT4                 not null,
   ID_CAMPO_PREENCHIMENTO INT4                 not null,
   constraint PK_CANDIDATO_PREENCHIMENTO primary key (ID_CANDIDADO_PREENCHIMENTO)
);

/*==============================================================*/
/* Table: CARGO                                                 */
/*==============================================================*/
create table CARGO (
   ID_CARGO             SERIAL not null,
   DSC_CARGO            VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_CARGO primary key (ID_CARGO)
);

/*==============================================================*/
/* Table: CREDICIAMENTO                                         */
/*==============================================================*/
create table CREDICIAMENTO (
   ID_CREDECIAMENTO     SERIAL not null,
   ID_CURSO             INT4                 not null,
   NUM_FREQUENCIA       VARCHAR(250)         not null,
   HORARIO_ENTRADA      TIMESTAMP            not null,
   DATA_CADASTRO        DATE                 not null,
   constraint PK_CREDICIAMENTO primary key (ID_CREDECIAMENTO)
);

/*==============================================================*/
/* Table: CURSO                                                 */
/*==============================================================*/
create table CURSO (
   ID_CURSO             SERIAL not null,
   ID_LOCALIZACAO       INT4                 not null,
   ID_AREA              INT4                 null,
   ID_OPCAO_LISTA_CAND  INT4                 not null,
   ID_USUARIO_GESTOR    INT4                 not null,
   ID_ORGAO_SOLICITANTE INT4                 null,
   ID_TURNO             INT4                 null,
   TITULO               VARCHAR(255)         not null,
   COD_CURSO            VARCHAR(255)         not null,
   DT_REALIZACAO_INICIO DATE                 not null,
   DT_REALIZACAO_FIM    DATE                 not null,
   DT_INICIO_INSCRICAO  DATE                 not null,
   DT_TERMINO_INSCRICAO DATE                 null,
   FLG_FINALIZADO       BOOL                 null,
   NUM_VAGAS            INT4                 null,
   FLG_REGIAO_ATIVO     BOOL                 not null,
   FLG_DATA_ATIVO       BOOL                 null,
   FLG_POSSUI_OFICINA   BOOL                 null,
   FLG_CURSO_PUBLICO    BOOL                 not null default TRUE,
   constraint PK_CURSO primary key (ID_CURSO)
);

comment on column CURSO.FLG_POSSUI_OFICINA is
'Indica se o curso é composto por oficina/matérias cuja as quais o candidato possa selecionar quais deseja cursar.';

/*==============================================================*/
/* Table: DISTRIBUICAO_SOF_GRADE                                */
/*==============================================================*/
create table DISTRIBUICAO_SOF_GRADE (
   ID_DISTRIBUICAO_SOF_GRADE SERIAL not null,
   ID_SELECAO_OFICINA   INT4                 not null,
   ID_GRADE_OFICINA     INT4                 not null,
   IND_CONFLITO         BOOL                 null,
   constraint PK_DISTRIBUICAO_SOF_GRADE primary key (ID_DISTRIBUICAO_SOF_GRADE)
);

comment on table DISTRIBUICAO_SOF_GRADE is
'Relaciona um registro de OFICINA selecionada pelo candidato a uma grade.';

/*==============================================================*/
/* Table: EMAIL_CURSO_PRIVADO                                   */
/*==============================================================*/
create table EMAIL_CURSO_PRIVADO (
   ID_EMAIL_CURSO       SERIAL not null,
   ID_CURSO             INT4                 not null,
   DSC_EMAIL            VARCHAR(255)         not null,
   constraint PK_EMAIL_CURSO_PRIVADO primary key (ID_EMAIL_CURSO)
);

/*==============================================================*/
/* Table: ESFERA_CURSO                                          */
/*==============================================================*/
create table ESFERA_CURSO (
   ID_ESFERA_CURSO      SERIAL not null,
   ID_ESFERA_GOV        INT4                 not null,
   ID_CURSO             INT4                 not null,
   constraint PK_ESFERA_CURSO primary key (ID_ESFERA_CURSO)
);

/*==============================================================*/
/* Table: ESFERA_GOVERNO                                        */
/*==============================================================*/
create table ESFERA_GOVERNO (
   ID_ESFERA_GOV        SERIAL not null,
   DSC_ESFERA_GOV       VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_ESFERA_GOVERNO primary key (ID_ESFERA_GOV)
);

INSERT INTO esfera_governo (id_esfera_gov, dsc_esfera_gov, flg_ativo) VALUES (1, 'Estadual', true);
INSERT INTO esfera_governo (id_esfera_gov, dsc_esfera_gov, flg_ativo) VALUES (2, 'Federal', true);
INSERT INTO esfera_governo (id_esfera_gov, dsc_esfera_gov, flg_ativo) VALUES (3, 'Municipal', true);
INSERT INTO esfera_governo (id_esfera_gov, dsc_esfera_gov, flg_ativo) VALUES (4, 'Outras', true);


SELECT setval('esfera_governo_id_esfera_gov_seq', 4);

/*==============================================================*/
/* Table: FREQUENCIA                                            */
/*==============================================================*/
create table FREQUENCIA (
   ID_FREQUENCIA        SERIAL not null,
   ID_GRADE_OFICINA     INT4                 null,
   HORARIO_ENTRADA      TIMESTAMP            null,
   HORARIO_SAIDA        TIMESTAMP            null,
   NUM_INCRICAO         VARCHAR(250)         null,
   constraint PK_FREQUENCIA primary key (ID_FREQUENCIA)
);

/*==============================================================*/
/* Table: FUNCIONALIDADE                                        */
/*==============================================================*/
create table FUNCIONALIDADE (
   ID_FUNCIONALIDADE    SERIAL not null,
   ID_FUNCIONAL_PAI     INT4                 null,
   DSC_FUNCIONALIDADE   VARCHAR(255)         not null,
   NOM_FUNCIONALIDADE   VARCHAR(255)         not null,
   NOM_ROLE             VARCHAR(255)         not null,
   constraint PK_FUNCIONALIDADE primary key (ID_FUNCIONALIDADE)
);

INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (1, NULL, 'ROLE_USER', 'Acesso ao sistema', 'ROLE_USER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (2, NULL, '', 'Cadastrar Curso', 'ROLE_CURSO_CADASTRO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (3, NULL, '', 'Pesquisar Curso', 'ROLE_CURSO_PESQUISAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (4, 3, '', 'Editar', 'ROLE_CURSO_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (5, 3, '', 'Remover', 'ROLE_CURSO_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (6, 3, '', 'Visualizar', 'ROLE_CURSO_VISUALIZAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (7, 3, '', 'Gerenciar', 'ROLE_CURSO_GERENCIAR_PESQ');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (8, NULL, '', 'Gerenciar Curso', 'ROLE_CURSO_GERENCIAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (9, 8, '', 'Finalizar Inscrição', 'ROLE_CURSO_FINALIZAR_INSCRICAO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (10, 8, '', 'Finalizar Curso', 'ROLE_CURSO_FINALIZAR_CURSO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (11, 8, '', 'Homologar', 'ROLE_CURSO_HOMOLOGAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (12, 8, '', 'Eleger Candidato', 'ROLE_CURSO_ELEGER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (13, 8, '', 'Cancelar Inscrição', 'ROLE_CURSO_CANCELAR_INSCRICAO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (14, 8, '', 'Invalidar Comprovante', 'ROLE_CURSO_INVALIDAR_COMPROVANTE');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (15, NULL, '', 'Comunicado - Mala Direta', 'ROLE_COMUNICADO_MALA_DIRETA');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (16, NULL, '', 'Area', 'ROLE_AREA');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (17, 16, '', 'Cadastrar', 'ROLE_AREA_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (18, 16, '', 'Excluir', 'ROLE_AREA_EXCLUIR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (19, 16, '', 'Editar', 'ROLE_AREA_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (20, NULL, '', 'Cargo', 'ROLE_CARGO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (21, 20, '', 'Cadastrar', 'ROLE_CARGO_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (22, 20, '', 'Remover', 'ROLE_CARGO_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (23, 20, '', 'Editar', 'ROLE_CARGO_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (24, NULL, '', 'Perfil', 'ROLE_PERFIL');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (25, 24, '', 'Cadastrar', 'ROLE_PERFIL_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (26, 24, '', 'Remover', 'ROLE_PERFIL_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (27, 24, '', 'Editar', 'ROLE_PERFIL_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (28, NULL, '', 'Usuario', 'ROLE_USUARIO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (29, 28, '', 'Cadastrar', 'ROLE_USUARIO_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (30, 28, '', 'Remover', 'ROLE_USUARIO_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (31, 28, '', 'Editar', 'ROLE_USUARIO_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (32, 28, '', 'Restaurar Senha', 'ROLE_USUARIO_RESTAURAR_SENHA');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (33, NULL, '', 'Localização', 'ROLE_LOCALIZACAO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (34, 33, '', 'Cadastrar', 'ROLE_LOCALIZACAO_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (35, 33, '', 'Remover', 'ROLE_LOCALIZACAO_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (36, 33, '', 'Editar', 'ROLE_LOCALIZACAO_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (37, NULL, '', 'Perfil Funcionalidade', 'ROLE_PERFIL_FUNCIONALIDADE');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (38, NULL, '', 'Orgão', 'ROLE_ORGAO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (39, 38, '', 'Cadastrar', 'ROLE_ORGAO_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (40, 38, '', 'Editar', 'ROLE_ORGAO_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (41, 38, '', 'Remover', 'ROLE_ORGAO_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (42, null, '', 'Atuação', 'ROLE_ATUACAO');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (43, 42, '', 'Cadastrar', 'ROLE_ATUACAO_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (44, 42, '', 'Remover', 'ROLE_ATUACAO_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (45, 42, '', 'Editar', 'ROLE_ATUACAO_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (46, 3, '', 'Acesso Geral', 'ROLE_PESQ_ACESSO_GERAL');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (47, null, '', 'Turma', 'ROLE_TURMA');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (48, 47, '', 'Cadastrar', 'ROLE_TURMA_CADASTRAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (49, 47, '', 'Remover', 'ROLE_TURMA_REMOVER');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (50, 47, '', 'Editar', 'ROLE_TURMA_EDITAR');
INSERT INTO funcionalidade (id_funcionalidade, id_funcional_pai, dsc_funcionalidade, nom_funcionalidade, nom_role) VALUES (51, null, '', 'Distribuir', 'ROLE_DISTRIBUIR');
SELECT setval('funcionalidade_id_funcionalidade_seq', 51);

/*==============================================================*/
/* Table: GRADE_OFICINA                                         */
/*==============================================================*/
create table GRADE_OFICINA (
   ID_GRADE_OFICINA     SERIAL not null,
   ID_OFICINA           INT4                 not null,
   ID_SALA              INT4                 not null,
   ID_TURMA             INT4                 not null,
   ID_PROFESSOR_EVENTO  INT4                 null,
   ID_HORARIO           INT4                 null,
   constraint PK_GRADE_OFICINA primary key (ID_GRADE_OFICINA)
);

comment on table GRADE_OFICINA is
'Contém as oficinas e todas as Turma X Horário X Sala X Professor';

/*==============================================================*/
/* Table: GRADE_PACOTE                                          */
/*==============================================================*/
create table GRADE_PACOTE (
   ID_GRADE_PACOTE      SERIAL not null,
   ID_PACOTE_OFICINA    INT4                 not null,
   ID_HORARIO           INT4                 not null,
   ID_TURMA             INT4                 not null,
   constraint PK_GRADE_PACOTE primary key (ID_GRADE_PACOTE)
);

comment on table GRADE_PACOTE is
'Relação entre Pacote e Oficina e Horário e Turma.
Horário e Turma deve ser único para uma mesma oficina.';

/*==============================================================*/
/* Table: HOMOLOGACAO                                           */
/*==============================================================*/
create table HOMOLOGACAO (
   ID_HOMOLOGACAO       SERIAL not null,
   DSC_HOMOLOGACAO      VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_HOMOLOGACAO primary key (ID_HOMOLOGACAO)
);

INSERT INTO homologacao (id_homologacao, dsc_homologacao, flg_ativo) VALUES (1, 'Confirmação de Pagamento', true);
INSERT INTO homologacao (id_homologacao, dsc_homologacao, flg_ativo) VALUES (2, 'Confirmação do Chefe', true);
INSERT INTO homologacao (id_homologacao, dsc_homologacao, flg_ativo) VALUES (3, 'Confirmação Via GRU', true);
INSERT INTO homologacao (id_homologacao, dsc_homologacao, flg_ativo) VALUES (4, 'Confirmação Por Nota de Empenho', true);


SELECT setval('homologacao_id_homologacao_seq', 4);

/*==============================================================*/
/* Table: HOMOLOGACAO_CURSO                                     */
/*==============================================================*/
create table HOMOLOGACAO_CURSO (
   ID_HOMOLOGACAO_CURSO SERIAL not null,
   ID_CURSO             INT4                 not null,
   ID_HOMOLOGACAO       INT4                 not null,
   constraint PK_HOMOLOGACAO_CURSO primary key (ID_HOMOLOGACAO_CURSO)
);

/*==============================================================*/
/* Table: HORARIO                                               */
/*==============================================================*/
create table HORARIO (
   ID_HORARIO           SERIAL not null,
   ID_CURSO             INT4                 null,
   DES_HORARIO          VARCHAR(50)          not null,
   DAT_HORA_INICIO      TIMESTAMP            not null,
   DAT_HORA_FIM         TIMESTAMP            not null,
   constraint PK_HORARIO primary key (ID_HORARIO)
);

comment on table HORARIO is
'Contém todos os horários disponíveis para montagem da grade com data/inicio e data/fim';

/*==============================================================*/
/* Table: INSCRICAO_COMPROVANTE                                 */
/*==============================================================*/
create table INSCRICAO_COMPROVANTE (
   ID_INSCRICAO_COMPROVANTE SERIAL not null,
   ID_INSCRICAO_CURSO   INT4                 not null,
   IMG_COMPROVANTE      BYTEA                null,
   DT_CADASTRO          DATE                 not null,
   NOM_ARQUIVO          VARCHAR(255)         not null,
   NOM_TIPO             VARCHAR(255)         not null,
   URL_COMPROVANTE      VARCHAR(1000)        null,
   constraint PK_INSCRICAO_COMPROVANTE primary key (ID_INSCRICAO_COMPROVANTE)
);

/*==============================================================*/
/* Table: INSCRICAO_CURSO                                       */
/*==============================================================*/
create table INSCRICAO_CURSO (
   ID_INSCRICAO_CURSO   SERIAL not null,
   ID_CURSO             INT4                 not null,
   ID_CANDIDATO         INT4                 not null,
   ID_SITUACAO          INT4                 not null,
   ID_TURMA             INT4                 null,
   DT_CADASTRO          TIMESTAMP            not null,
   NUM_INSCRICAO        VARCHAR(255)         null,
   ANO_HOMOLOGACAO      int                  null,
   constraint PK_INSCRICAO_CURSO primary key (ID_INSCRICAO_CURSO)
);

/*==============================================================*/
/* Table: INSCRICAO_ESFERA                                      */
/*==============================================================*/
create table INSCRICAO_ESFERA (
   ID_INSCRICAO_ESFERA  SERIAL not null,
   ID_INSCRICAO_CURSO   INT4                 not null,
   ID_ESFERA_GOV        INT4                 not null,
   constraint PK_INSCRICAO_ESFERA primary key (ID_INSCRICAO_ESFERA)
);

/*==============================================================*/
/* Table: INSCRICAO_INFOR_COMPLEMENTAR                          */
/*==============================================================*/
create table INSCRICAO_INFOR_COMPLEMENTAR (
   ID_INSCR_INFOR_COMPLEMENTAR SERIAL not null,
   ID_INSCRICAO_CURSO   INT4                 not null,
   ID_ORGAO             INT4                 not null,
   NUM_EMPENHO          VARCHAR(255)         not null,
   END_ORGAO_COMPLETO   VARCHAR(255)         not null,
   CNPJ                 VARCHAR(14)          not null,
   CONTATO              VARCHAR(255)         null,
   TEL_SETOR_FINANC     VARCHAR(255)         null,
   constraint PK_INSCRICAO_INFOR_COMPLEMENTA primary key (ID_INSCR_INFOR_COMPLEMENTAR)
);

/*==============================================================*/
/* Table: LOCALIZACAO                                           */
/*==============================================================*/
create table LOCALIZACAO (
   ID_LOCALIZACAO       SERIAL not null,
   DEN_LOCALIZACAO      VARCHAR(255)         not null,
   DESC_LOCALIZACAO     TEXT                 null,
   constraint PK_LOCALIZACAO primary key (ID_LOCALIZACAO)
);

/*==============================================================*/
/* Table: MUNICIPIO                                             */
/*==============================================================*/
create table MUNICIPIO (
   ID_MUNICIPIO         SERIAL not null,
   ID_UF                INT4                 not null,
   DESCRICAO            VARCHAR(255)         not null,
   constraint PK_MUNICIPIO primary key (ID_MUNICIPIO)
);



INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100015,11,'ALTA FLORESTA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100023,11,'ARIQUEMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100031,11,'CABIXI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100049,11,'CACOAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100056,11,'CEREJEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100064,11,'COLORADO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100072,11,'CORUMBIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100080,11,'COSTA MARQUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100098,11,'ESPIGÃO D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100106,11,'GUAJARÁ-MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100114,11,'JARU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100122,11,'JI-PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100130,11,'MACHADINHO D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100148,11,'NOVA BRASILÂNDIA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100155,11,'OURO PRETO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100189,11,'PIMENTA BUENO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100205,11,'PORTO VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100254,11,'PRESIDENTE MÉDICI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100262,11,'RIO CRESPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100288,11,'ROLIM DE MOURA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100296,11,'SANTA LUZIA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100304,11,'VILHENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100320,11,'SÃO MIGUEL DO GUAPORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100338,11,'NOVA MAMORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100346,11,'ALVORADA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100379,11,'ALTO ALEGRE DOS PARECIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100403,11,'ALTO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100452,11,'BURITIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100502,11,'NOVO HORIZONTE DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100601,11,'CACAULÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100700,11,'CAMPO NOVO DE RONDÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100809,11,'CANDEIAS DO JAMARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100908,11,'CASTANHEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100924,11,'CHUPINGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1100940,11,'CUJUBIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101005,11,'GOVERNADOR JORGE TEIXEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101104,11,'ITAPUÃ DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101203,11,'MINISTRO ANDREAZZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101302,11,'MIRANTE DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101401,11,'MONTE NEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101435,11,'NOVA UNIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101450,11,'PARECIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101468,11,'PIMENTEIRAS DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101476,11,'PRIMAVERA DE RONDÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101484,11,'SÃO FELIPE D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101492,11,'SÃO FRANCISCO DO GUAPORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101500,11,'SERINGUEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101559,11,'TEIXEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101609,11,'THEOBROMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101708,11,'URUPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101757,11,'VALE DO ANARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1101807,11,'VALE DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200013,12,'ACRELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200054,12,'ASSIS BRASIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200104,12,'BRASILÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200138,12,'BUJARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200179,12,'CAPIXABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200203,12,'CRUZEIRO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200252,12,'EPITACIOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200302,12,'FEIJÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200328,12,'JORDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200336,12,'MÂNCIO LIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200344,12,'MANOEL URBANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200351,12,'MARECHAL THAUMATURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200385,12,'PLÁCIDO DE CASTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200393,12,'PORTO WALTER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200401,12,'RIO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200427,12,'RODRIGUES ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200435,12,'SANTA ROSA DO PURUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200450,12,'SENADOR GUIOMARD');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200500,12,'SENA MADUREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200609,12,'TARAUACÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200708,12,'XAPURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1200807,12,'PORTO ACRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300029,13,'ALVARÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300060,13,'AMATURÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300086,13,'ANAMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300102,13,'ANORI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300144,13,'APUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300201,13,'ATALAIA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300300,13,'AUTAZES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300409,13,'BARCELOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300508,13,'BARREIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300607,13,'BENJAMIN CONSTANT');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300631,13,'BERURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300680,13,'BOA VISTA DO RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300706,13,'BOCA DO ACRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300805,13,'BORBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300839,13,'CAAPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1300904,13,'CANUTAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301001,13,'CARAUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301100,13,'CAREIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301159,13,'CAREIRO DA VÁRZEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301209,13,'COARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301308,13,'CODAJÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301407,13,'EIRUNEPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301506,13,'ENVIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301605,13,'FONTE BOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301654,13,'GUAJARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301704,13,'HUMAITÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301803,13,'IPIXUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301852,13,'IRANDUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301902,13,'ITACOATIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1301951,13,'ITAMARATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302009,13,'ITAPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302108,13,'JAPURÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302207,13,'JURUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302306,13,'JUTAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302405,13,'LÁBREA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302504,13,'MANACAPURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302553,13,'MANAQUIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302603,13,'MANAUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302702,13,'MANICORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302801,13,'MARAÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1302900,13,'MAUÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303007,13,'NHAMUNDÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303106,13,'NOVA OLINDA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303205,13,'NOVO AIRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303304,13,'NOVO ARIPUANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303403,13,'PARINTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303502,13,'PAUINI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303536,13,'PRESIDENTE FIGUEIREDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303569,13,'RIO PRETO DA EVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303601,13,'SANTA ISABEL DO RIO NEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303700,13,'SANTO ANTÔNIO DO IÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303809,13,'SÃO GABRIEL DA CACHOEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303908,13,'SÃO PAULO DE OLIVENÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1303957,13,'SÃO SEBASTIÃO DO UATUMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304005,13,'SILVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304062,13,'TABATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304104,13,'TAPAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304203,13,'TEFÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304237,13,'TONANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304260,13,'UARINI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304302,13,'URUCARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1304401,13,'URUCURITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400027,14,'AMAJARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400050,14,'ALTO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400100,14,'BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400159,14,'BONFIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400175,14,'CANTÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400209,14,'CARACARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400233,14,'CAROEBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400282,14,'IRACEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400308,14,'MUCAJAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400407,14,'NORMANDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400456,14,'PACARAIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400472,14,'RORAINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400506,14,'SÃO JOÃO DA BALIZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400605,14,'SÃO LUIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1400704,14,'UIRAMUTÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500107,15,'ABAETETUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500131,15,'ABEL FIGUEIREDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500206,15,'ACARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500305,15,'AFUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500347,15,'ÁGUA AZUL DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500404,15,'ALENQUER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500503,15,'ALMEIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500602,15,'ALTAMIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500701,15,'ANAJÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500800,15,'ANANINDEUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500859,15,'ANAPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500909,15,'AUGUSTO CORRÊA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1500958,15,'AURORA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501006,15,'AVEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501105,15,'BAGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501204,15,'BAIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501253,15,'BANNACH');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501303,15,'BARCARENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501402,15,'BELÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501451,15,'BELTERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501501,15,'BENEVIDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501576,15,'BOM JESUS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501600,15,'BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501709,15,'BRAGANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501725,15,'BRASIL NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501758,15,'BREJO GRANDE DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501782,15,'BREU BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501808,15,'BREVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501907,15,'BUJARU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1501956,15,'CACHOEIRA DO PIRIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502004,15,'CACHOEIRA DO ARARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502103,15,'CAMETÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502152,15,'CANAÃ DOS CARAJÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502202,15,'CAPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502301,15,'CAPITÃO POÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502400,15,'CASTANHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502509,15,'CHAVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502608,15,'COLARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502707,15,'CONCEIÇÃO DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502756,15,'CONCÓRDIA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502764,15,'CUMARU DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502772,15,'CURIONÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502806,15,'CURRALINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502855,15,'CURUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502905,15,'CURUÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502939,15,'DOM ELISEU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1502954,15,'ELDORADO DOS CARAJÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503002,15,'FARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503044,15,'FLORESTA DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503077,15,'GARRAFÃO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503093,15,'GOIANÉSIA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503101,15,'GURUPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503200,15,'IGARAPÉ-AÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503309,15,'IGARAPÉ-MIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503408,15,'INHANGAPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503457,15,'IPIXUNA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503507,15,'IRITUIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503606,15,'ITAITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503705,15,'ITUPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503754,15,'JACAREACANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503804,15,'JACUNDÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1503903,15,'JURUTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504000,15,'LIMOEIRO DO AJURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504059,15,'MÃE DO RIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504109,15,'MAGALHÃES BARATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504208,15,'MARABÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504307,15,'MARACANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504406,15,'MARAPANIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504422,15,'MARITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504455,15,'MEDICILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504505,15,'MELGAÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504604,15,'MOCAJUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504703,15,'MOJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504802,15,'MONTE ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504901,15,'MUANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504950,15,'NOVA ESPERANÇA DO PIRIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1504976,15,'NOVA IPIXUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505007,15,'NOVA TIMBOTEUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505031,15,'NOVO PROGRESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505064,15,'NOVO REPARTIMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505106,15,'ÓBIDOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505205,15,'OEIRAS DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505304,15,'ORIXIMINÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505403,15,'OURÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505437,15,'OURILÂNDIA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505486,15,'PACAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505494,15,'PALESTINA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505502,15,'PARAGOMINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505536,15,'PARAUAPEBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505551,15,'PAU D''ARCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505601,15,'PEIXE-BOI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505635,15,'PIÇARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505650,15,'PLACAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505700,15,'PONTA DE PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505809,15,'PORTEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1505908,15,'PORTO DE MOZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506005,15,'PRAINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506104,15,'PRIMAVERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506112,15,'QUATIPURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506138,15,'REDENÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506161,15,'RIO MARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506187,15,'RONDON DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506195,15,'RURÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506203,15,'SALINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506302,15,'SALVATERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506351,15,'SANTA BÁRBARA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506401,15,'SANTA CRUZ DO ARARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506500,15,'SANTA ISABEL DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506559,15,'SANTA LUZIA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506583,15,'SANTA MARIA DAS BARREIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506609,15,'SANTA MARIA DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506708,15,'SANTANA DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506807,15,'SANTARÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1506906,15,'SANTARÉM NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507003,15,'SANTO ANTÔNIO DO TAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507102,15,'SÃO CAETANO DE ODIVELAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507151,15,'SÃO DOMINGOS DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507201,15,'SÃO DOMINGOS DO CAPIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507300,15,'SÃO FÉLIX DO XINGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507409,15,'SÃO FRANCISCO DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507458,15,'SÃO GERALDO DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507466,15,'SÃO JOÃO DA PONTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507474,15,'SÃO JOÃO DE PIRABAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507508,15,'SÃO JOÃO DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507607,15,'SÃO MIGUEL DO GUAMÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507706,15,'SÃO SEBASTIÃO DA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507755,15,'SAPUCAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507805,15,'SENADOR JOSÉ PORFÍRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507904,15,'SOURE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507953,15,'TAILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507961,15,'TERRA ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1507979,15,'TERRA SANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508001,15,'TOMÉ-AÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508035,15,'TRACUATEUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508050,15,'TRAIRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508084,15,'TUCUMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508100,15,'TUCURUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508126,15,'ULIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508159,15,'URUARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508209,15,'VIGIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508308,15,'VISEU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508357,15,'VITÓRIA DO XINGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1508407,15,'XINGUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600055,16,'SERRA DO NAVIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600105,16,'AMAPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600154,16,'PEDRA BRANCA DO AMAPARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600204,16,'CALÇOENE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600212,16,'CUTIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600238,16,'FERREIRA GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600253,16,'ITAUBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600279,16,'LARANJAL DO JARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600303,16,'MACAPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600402,16,'MAZAGÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600501,16,'OIAPOQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600535,16,'PORTO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600550,16,'PRACUÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600600,16,'SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600709,16,'TARTARUGALZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1600808,16,'VITÓRIA DO JARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1700251,17,'ABREULÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1700301,17,'AGUIARNÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1700350,17,'ALIANÇA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1700400,17,'ALMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1700707,17,'ALVORADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1701002,17,'ANANÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1701051,17,'ANGICO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1701101,17,'APARECIDA DO RIO NEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1701309,17,'ARAGOMINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1701903,17,'ARAGUACEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702000,17,'ARAGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702109,17,'ARAGUAÍNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702158,17,'ARAGUANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702208,17,'ARAGUATINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702307,17,'ARAPOEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702406,17,'ARRAIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702554,17,'AUGUSTINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702703,17,'AURORA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1702901,17,'AXIXÁ DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703008,17,'BABAÇULÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703057,17,'BANDEIRANTES DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703073,17,'BARRA DO OURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703107,17,'BARROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703206,17,'BERNARDO SAYÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703305,17,'BOM JESUS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703602,17,'BRASILÂNDIA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703701,17,'BREJINHO DE NAZARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703800,17,'BURITI DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703826,17,'CACHOEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703842,17,'CAMPOS LINDOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703867,17,'CARIRI DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703883,17,'CARMOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703891,17,'CARRASCO BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1703909,17,'CASEARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1704105,17,'CENTENÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1704600,17,'CHAPADA DE AREIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1705102,17,'CHAPADA DA NATIVIDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1705508,17,'COLINAS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1705557,17,'COMBINADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1705607,17,'CONCEIÇÃO DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1706001,17,'COUTO DE MAGALHÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1706100,17,'CRISTALÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1706258,17,'CRIXÁS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1706506,17,'DARCINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707009,17,'DIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707108,17,'DIVINÓPOLIS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707207,17,'DOIS IRMÃOS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707306,17,'DUERÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707405,17,'ESPERANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707553,17,'FÁTIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707652,17,'FIGUEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1707702,17,'FILADÉLFIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1708205,17,'FORMOSO DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1708254,17,'FORTALEZA DO TABOCÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1708304,17,'GOIANORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1709005,17,'GOIATINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1709302,17,'GUARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1709500,17,'GURUPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1709807,17,'IPUEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1710508,17,'ITACAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1710706,17,'ITAGUATINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1710904,17,'ITAPIRATINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1711100,17,'ITAPORÃ DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1711506,17,'JAÚ DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1711803,17,'JUARINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1711902,17,'LAGOA DA CONFUSÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1711951,17,'LAGOA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712009,17,'LAJEADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712157,17,'LAVANDEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712405,17,'LIZARDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712454,17,'LUZINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712504,17,'MARIANÓPOLIS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712702,17,'MATEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1712801,17,'MAURILÂNDIA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1713205,17,'MIRACEMA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1713304,17,'MIRANORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1713601,17,'MONTE DO CARMO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1713700,17,'MONTE SANTO DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1713809,17,'PALMEIRAS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1713957,17,'MURICILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1714203,17,'NATIVIDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1714302,17,'NAZARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1714880,17,'NOVA OLINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715002,17,'NOVA ROSALÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715101,17,'NOVO ACORDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715150,17,'NOVO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715259,17,'NOVO JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715507,17,'OLIVEIRA DE FÁTIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715705,17,'PALMEIRANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1715754,17,'PALMEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716109,17,'PARAÍSO DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716208,17,'PARANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716307,17,'PAU D''ARCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716505,17,'PEDRO AFONSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716604,17,'PEIXE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716653,17,'PEQUIZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1716703,17,'COLMÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1717008,17,'PINDORAMA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1717206,17,'PIRAQUÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1717503,17,'PIUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1717800,17,'PONTE ALTA DO BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1717909,17,'PONTE ALTA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718006,17,'PORTO ALEGRE DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718204,17,'PORTO NACIONAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718303,17,'PRAIA NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718402,17,'PRESIDENTE KENNEDY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718451,17,'PUGMIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718501,17,'RECURSOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718550,17,'RIACHINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718659,17,'RIO DA CONCEIÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718709,17,'RIO DOS BOIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718758,17,'RIO SONO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718808,17,'SAMPAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718840,17,'SANDOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718865,17,'SANTA FÉ DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718881,17,'SANTA MARIA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718899,17,'SANTA RITA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1718907,17,'SANTA ROSA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1719004,17,'SANTA TEREZA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720002,17,'SANTA TEREZINHA DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720101,17,'SÃO BENTO DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720150,17,'SÃO FÉLIX DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720200,17,'SÃO MIGUEL DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720259,17,'SÃO SALVADOR DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720309,17,'SÃO SEBASTIÃO DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720499,17,'SÃO VALÉRIO DA NATIVIDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720655,17,'SILVANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720804,17,'SÍTIO NOVO DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720853,17,'SUCUPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720903,17,'TAGUATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720937,17,'TAIPAS DO TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1720978,17,'TALISMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1721000,17,'PALMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1721109,17,'TOCANTÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1721208,17,'TOCANTINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1721257,17,'TUPIRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1721307,17,'TUPIRATINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1722081,17,'WANDERLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (1722107,17,'XAMBIOÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100055,21,'AÇAILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100105,21,'AFONSO CUNHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100154,21,'ÁGUA DOCE DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100204,21,'ALCÂNTARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100303,21,'ALDEIAS ALTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100402,21,'ALTAMIRA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100436,21,'ALTO ALEGRE DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100477,21,'ALTO ALEGRE DO PINDARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100501,21,'ALTO PARNAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100550,21,'AMAPÁ DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100600,21,'AMARANTE DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100709,21,'ANAJATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100808,21,'ANAPURUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100832,21,'APICUM-AÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100873,21,'ARAGUANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100907,21,'ARAIOSES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2100956,21,'ARAME');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101004,21,'ARARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101103,21,'AXIXÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101202,21,'BACABAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101251,21,'BACABEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101301,21,'BACURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101350,21,'BACURITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101400,21,'BALSAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101509,21,'BARÃO DE GRAJAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101608,21,'BARRA DO CORDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101707,21,'BARREIRINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101731,21,'BELÁGUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101772,21,'BELA VISTA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101806,21,'BENEDITO LEITE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101905,21,'BEQUIMÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101939,21,'BERNARDO DO MEARIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2101970,21,'BOA VISTA DO GURUPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102002,21,'BOM JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102036,21,'BOM JESUS DAS SELVAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102077,21,'BOM LUGAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102101,21,'BREJO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102150,21,'BREJO DE AREIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102200,21,'BURITI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102309,21,'BURITI BRAVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102325,21,'BURITICUPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102358,21,'BURITIRANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102374,21,'CACHOEIRA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102408,21,'CAJAPIÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102507,21,'CAJARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102556,21,'CAMPESTRE DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102606,21,'CÂNDIDO MENDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102705,21,'CANTANHEDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102754,21,'CAPINZAL DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102804,21,'CAROLINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2102903,21,'CARUTAPERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103000,21,'CAXIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103109,21,'CEDRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103125,21,'CENTRAL DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103158,21,'CENTRO DO GUILHERME');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103174,21,'CENTRO NOVO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103208,21,'CHAPADINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103257,21,'CIDELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103307,21,'CODÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103406,21,'COELHO NETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103505,21,'COLINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103554,21,'CONCEIÇÃO DO LAGO-AÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103604,21,'COROATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103703,21,'CURURUPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103752,21,'DAVINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103802,21,'DOM PEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2103901,21,'DUQUE BACELAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104008,21,'ESPERANTINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104057,21,'ESTREITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104073,21,'FEIRA NOVA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104081,21,'FERNANDO FALCÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104099,21,'FORMOSA DA SERRA NEGRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104107,21,'FORTALEZA DOS NOGUEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104206,21,'FORTUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104305,21,'GODOFREDO VIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104404,21,'GONÇALVES DIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104503,21,'GOVERNADOR ARCHER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104552,21,'GOVERNADOR EDISON LOBÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104602,21,'GOVERNADOR EUGÊNIO BARROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104628,21,'GOVERNADOR LUIZ ROCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104651,21,'GOVERNADOR NEWTON BELLO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104677,21,'GOVERNADOR NUNES FREIRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104701,21,'GRAÇA ARANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104800,21,'GRAJAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2104909,21,'GUIMARÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105005,21,'HUMBERTO DE CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105104,21,'ICATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105153,21,'IGARAPÉ DO MEIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105203,21,'IGARAPÉ GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105302,21,'IMPERATRIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105351,21,'ITAIPAVA DO GRAJAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105401,21,'ITAPECURU MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105427,21,'ITINGA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105450,21,'JATOBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105476,21,'JENIPAPO DOS VIEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105500,21,'JOÃO LISBOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105609,21,'JOSELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105658,21,'JUNCO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105708,21,'LAGO DA PEDRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105807,21,'LAGO DO JUNCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105906,21,'LAGO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105922,21,'LAGOA DO MATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105948,21,'LAGO DOS RODRIGUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105963,21,'LAGOA GRANDE DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2105989,21,'LAJEADO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106003,21,'LIMA CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106102,21,'LORETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106201,21,'LUÍS DOMINGUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106300,21,'MAGALHÃES DE ALMEIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106326,21,'MARACAÇUMÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106359,21,'MARAJÁ DO SENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106375,21,'MARANHÃOZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106409,21,'MATA ROMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106508,21,'MATINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106607,21,'MATÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106631,21,'MATÕES DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106672,21,'MILAGRES DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106706,21,'MIRADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106755,21,'MIRANDA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106805,21,'MIRINZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2106904,21,'MONÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107001,21,'MONTES ALTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107100,21,'MORROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107209,21,'NINA RODRIGUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107258,21,'NOVA COLINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107308,21,'NOVA IORQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107357,21,'NOVA OLINDA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107407,21,'OLHO D''ÁGUA DAS CUNHÃS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107456,21,'OLINDA NOVA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107506,21,'PAÇO DO LUMIAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107605,21,'PALMEIRÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107704,21,'PARAIBANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107803,21,'PARNARAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2107902,21,'PASSAGEM FRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108009,21,'PASTOS BONS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108058,21,'PAULINO NEVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108108,21,'PAULO RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108207,21,'PEDREIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108256,21,'PEDRO DO ROSÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108306,21,'PENALVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108405,21,'PERI MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108454,21,'PERITORÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108504,21,'PINDARÉ-MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108603,21,'PINHEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108702,21,'PIO XII');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108801,21,'PIRAPEMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2108900,21,'POÇÃO DE PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109007,21,'PORTO FRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109056,21,'PORTO RICO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109106,21,'PRESIDENTE DUTRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109205,21,'PRESIDENTE JUSCELINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109239,21,'PRESIDENTE MÉDICI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109270,21,'PRESIDENTE SARNEY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109304,21,'PRESIDENTE VARGAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109403,21,'PRIMEIRA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109452,21,'RAPOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109502,21,'RIACHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109551,21,'RIBAMAR FIQUENE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109601,21,'ROSÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109700,21,'SAMBAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109759,21,'SANTA FILOMENA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109809,21,'SANTA HELENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2109908,21,'SANTA INÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110005,21,'SANTA LUZIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110039,21,'SANTA LUZIA DO PARUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110104,21,'SANTA QUITÉRIA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110203,21,'SANTA RITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110237,21,'SANTANA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110278,21,'SANTO AMARO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110302,21,'SANTO ANTÔNIO DOS LOPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110401,21,'SÃO BENEDITO DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110500,21,'SÃO BENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110609,21,'SÃO BERNARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110658,21,'SÃO DOMINGOS DO AZEITÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110708,21,'SÃO DOMINGOS DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110807,21,'SÃO FÉLIX DE BALSAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110856,21,'SÃO FRANCISCO DO BREJÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2110906,21,'SÃO FRANCISCO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111003,21,'SÃO JOÃO BATISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111029,21,'SÃO JOÃO DO CARÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111052,21,'SÃO JOÃO DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111078,21,'SÃO JOÃO DO SOTER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111102,21,'SÃO JOÃO DOS PATOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111201,21,'SÃO JOSÉ DE RIBAMAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111250,21,'SÃO JOSÉ DOS BASÍLIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111300,21,'SÃO LUÍS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111409,21,'SÃO LUÍS GONZAGA DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111508,21,'SÃO MATEUS DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111532,21,'SÃO PEDRO DA ÁGUA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111573,21,'SÃO PEDRO DOS CRENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111607,21,'SÃO RAIMUNDO DAS MANGABEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111631,21,'SÃO RAIMUNDO DO DOCA BEZERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111672,21,'SÃO ROBERTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111706,21,'SÃO VICENTE FERRER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111722,21,'SATUBINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111748,21,'SENADOR ALEXANDRE COSTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111763,21,'SENADOR LA ROCQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111789,21,'SERRANO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111805,21,'SÍTIO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111904,21,'SUCUPIRA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2111953,21,'SUCUPIRA DO RIACHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112001,21,'TASSO FRAGOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112100,21,'TIMBIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112209,21,'TIMON');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112233,21,'TRIZIDELA DO VALE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112274,21,'TUFILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112308,21,'TUNTUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112407,21,'TURIAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112456,21,'TURILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112506,21,'TUTÓIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112605,21,'URBANO SANTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112704,21,'VARGEM GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112803,21,'VIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112852,21,'VILA NOVA DOS MARTÍRIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2112902,21,'VITÓRIA DO MEARIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2113009,21,'VITORINO FREIRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2114007,21,'ZÉ DOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200053,22,'ACAUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200103,22,'AGRICOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200202,22,'ÁGUA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200251,22,'ALAGOINHA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200277,22,'ALEGRETE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200301,22,'ALTO LONGÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200400,22,'ALTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200459,22,'ALVORADA DO GURGUÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200509,22,'AMARANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200608,22,'ANGICAL DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200707,22,'ANÍSIO DE ABREU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200806,22,'ANTÔNIO ALMEIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200905,22,'AROAZES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2200954,22,'AROEIRAS DO ITAIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201002,22,'ARRAIAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201051,22,'ASSUNÇÃO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201101,22,'AVELINO LOPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201150,22,'BAIXA GRANDE DO RIBEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201176,22,'BARRA D''ALCÂNTARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201200,22,'BARRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201309,22,'BARREIRAS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201408,22,'BARRO DURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201507,22,'BATALHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201556,22,'BELA VISTA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201572,22,'BELÉM DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201606,22,'BENEDITINOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201705,22,'BERTOLÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201739,22,'BETÂNIA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201770,22,'BOA HORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201804,22,'BOCAINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201903,22,'BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201919,22,'BOM PRINCÍPIO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201929,22,'BONFIM DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201945,22,'BOQUEIRÃO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201960,22,'BRASILEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2201988,22,'BREJO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202000,22,'BURITI DOS LOPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202026,22,'BURITI DOS MONTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202059,22,'CABECEIRAS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202075,22,'CAJAZEIRAS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202083,22,'CAJUEIRO DA PRAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202091,22,'CALDEIRÃO GRANDE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202109,22,'CAMPINAS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202117,22,'CAMPO ALEGRE DO FIDALGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202133,22,'CAMPO GRANDE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202174,22,'CAMPO LARGO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202208,22,'CAMPO MAIOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202251,22,'CANAVIEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202307,22,'CANTO DO BURITI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202406,22,'CAPITÃO DE CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202455,22,'CAPITÃO GERVÁSIO OLIVEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202505,22,'CARACOL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202539,22,'CARAÚBAS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202554,22,'CARIDADE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202604,22,'CASTELO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202653,22,'CAXINGÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202703,22,'COCAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202711,22,'COCAL DE TELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202729,22,'COCAL DOS ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202737,22,'COIVARAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202752,22,'COLÔNIA DO GURGUÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202778,22,'COLÔNIA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202802,22,'CONCEIÇÃO DO CANINDÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202851,22,'CORONEL JOSÉ DIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2202901,22,'CORRENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203008,22,'CRISTALÂNDIA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203107,22,'CRISTINO CASTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203206,22,'CURIMATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203230,22,'CURRAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203255,22,'CURRALINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203271,22,'CURRAL NOVO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203305,22,'DEMERVAL LOBÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203354,22,'DIRCEU ARCOVERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203404,22,'DOM EXPEDITO LOPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203420,22,'DOMINGOS MOURÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203453,22,'DOM INOCÊNCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203503,22,'ELESBÃO VELOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203602,22,'ELISEU MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203701,22,'ESPERANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203750,22,'FARTURA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203800,22,'FLORES DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203859,22,'FLORESTA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2203909,22,'FLORIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204006,22,'FRANCINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204105,22,'FRANCISCO AYRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204154,22,'FRANCISCO MACEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204204,22,'FRANCISCO SANTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204303,22,'FRONTEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204352,22,'GEMINIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204402,22,'GILBUÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204501,22,'GUADALUPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204550,22,'GUARIBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204600,22,'HUGO NAPOLEÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204659,22,'ILHA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204709,22,'INHUMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204808,22,'IPIRANGA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2204907,22,'ISAÍAS COELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205003,22,'ITAINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205102,22,'ITAUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205151,22,'JACOBINA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205201,22,'JAICÓS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205250,22,'JARDIM DO MULATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205276,22,'JATOBÁ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205300,22,'JERUMENHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205359,22,'JOÃO COSTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205409,22,'JOAQUIM PIRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205458,22,'JOCA MARQUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205508,22,'JOSÉ DE FREITAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205516,22,'JUAZEIRO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205524,22,'JÚLIO BORGES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205532,22,'JUREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205540,22,'LAGOINHA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205557,22,'LAGOA ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205565,22,'LAGOA DO BARRO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205573,22,'LAGOA DE SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205581,22,'LAGOA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205599,22,'LAGOA DO SÍTIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205607,22,'LANDRI SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205706,22,'LUÍS CORREIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205805,22,'LUZILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205854,22,'MADEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205904,22,'MANOEL EMÍDIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2205953,22,'MARCOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206001,22,'MARCOS PARENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206050,22,'MASSAPÊ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206100,22,'MATIAS OLÍMPIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206209,22,'MIGUEL ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206308,22,'MIGUEL LEÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206357,22,'MILTON BRANDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206407,22,'MONSENHOR GIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206506,22,'MONSENHOR HIPÓLITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206605,22,'MONTE ALEGRE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206654,22,'MORRO CABEÇA NO TEMPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206670,22,'MORRO DO CHAPÉU DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206696,22,'MURICI DOS PORTELAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206704,22,'NAZARÉ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206753,22,'NOSSA SENHORA DE NAZARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206803,22,'NOSSA SENHORA DOS REMÉDIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206902,22,'NOVO ORIENTE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2206951,22,'NOVO SANTO ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207009,22,'OEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207108,22,'OLHO D''ÁGUA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207207,22,'PADRE MARCOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207306,22,'PAES LANDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207355,22,'PAJEÚ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207405,22,'PALMEIRA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207504,22,'PALMEIRAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207553,22,'PAQUETÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207603,22,'PARNAGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207702,22,'PARNAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207751,22,'PASSAGEM FRANCA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207777,22,'PATOS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207793,22,'PAU D''ARCO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207801,22,'PAULISTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207850,22,'PAVUSSU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207900,22,'PEDRO II');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207934,22,'PEDRO LAURENTINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2207959,22,'NOVA SANTA RITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208007,22,'PICOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208106,22,'PIMENTEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208205,22,'PIO IX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208304,22,'PIRACURUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208403,22,'PIRIPIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208502,22,'PORTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208551,22,'PORTO ALEGRE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208601,22,'PRATA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208650,22,'QUEIMADA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208700,22,'REDENÇÃO DO GURGUÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208809,22,'REGENERAÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208858,22,'RIACHO FRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208874,22,'RIBEIRA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2208908,22,'RIBEIRO GONÇALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209005,22,'RIO GRANDE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209104,22,'SANTA CRUZ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209153,22,'SANTA CRUZ DOS MILAGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209203,22,'SANTA FILOMENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209302,22,'SANTA LUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209351,22,'SANTANA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209377,22,'SANTA ROSA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209401,22,'SANTO ANTÔNIO DE LISBOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209450,22,'SANTO ANTÔNIO DOS MILAGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209500,22,'SANTO INÁCIO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209559,22,'SÃO BRAZ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209609,22,'SÃO FÉLIX DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209658,22,'SÃO FRANCISCO DE ASSIS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209708,22,'SÃO FRANCISCO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209757,22,'SÃO GONÇALO DO GURGUÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209807,22,'SÃO GONÇALO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209856,22,'SÃO JOÃO DA CANABRAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209872,22,'SÃO JOÃO DA FRONTEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209906,22,'SÃO JOÃO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209955,22,'SÃO JOÃO DA VARJOTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2209971,22,'SÃO JOÃO DO ARRAIAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210003,22,'SÃO JOÃO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210052,22,'SÃO JOSÉ DO DIVINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210102,22,'SÃO JOSÉ DO PEIXE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210201,22,'SÃO JOSÉ DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210300,22,'SÃO JULIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210359,22,'SÃO LOURENÇO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210375,22,'SÃO LUIS DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210383,22,'SÃO MIGUEL DA BAIXA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210391,22,'SÃO MIGUEL DO FIDALGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210409,22,'SÃO MIGUEL DO TAPUIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210508,22,'SÃO PEDRO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210607,22,'SÃO RAIMUNDO NONATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210623,22,'SEBASTIÃO BARROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210631,22,'SEBASTIÃO LEAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210656,22,'SIGEFREDO PACHECO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210706,22,'SIMÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210805,22,'SIMPLÍCIO MENDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210904,22,'SOCORRO DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210938,22,'SUSSUAPARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210953,22,'TAMBORIL DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2210979,22,'TANQUE DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211001,22,'TERESINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211100,22,'UNIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211209,22,'URUÇUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211308,22,'VALENÇA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211357,22,'VÁRZEA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211407,22,'VÁRZEA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211506,22,'VERA MENDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211605,22,'VILA NOVA DO PIAUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2211704,22,'WALL FERRAZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300101,23,'ABAIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300150,23,'ACARAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300200,23,'ACARAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300309,23,'ACOPIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300408,23,'AIUABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300507,23,'ALCÂNTARAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300606,23,'ALTANEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300705,23,'ALTO SANTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300754,23,'AMONTADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300804,23,'ANTONINA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2300903,23,'APUIARÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301000,23,'AQUIRAZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301109,23,'ARACATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301208,23,'ARACOIABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301257,23,'ARARENDÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301307,23,'ARARIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301406,23,'ARATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301505,23,'ARNEIROZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301604,23,'ASSARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301703,23,'AURORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301802,23,'BAIXIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301851,23,'BANABUIÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301901,23,'BARBALHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2301950,23,'BARREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302008,23,'BARRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302057,23,'BARROQUINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302107,23,'BATURITÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302206,23,'BEBERIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302305,23,'BELA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302404,23,'BOA VIAGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302503,23,'BREJO SANTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302602,23,'CAMOCIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302701,23,'CAMPOS SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302800,23,'CANINDÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2302909,23,'CAPISTRANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303006,23,'CARIDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303105,23,'CARIRÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303204,23,'CARIRIAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303303,23,'CARIÚS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303402,23,'CARNAUBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303501,23,'CASCAVEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303600,23,'CATARINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303659,23,'CATUNDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303709,23,'CAUCAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303808,23,'CEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303907,23,'CHAVAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303931,23,'CHORÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2303956,23,'CHOROZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304004,23,'COREAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304103,23,'CRATEÚS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304202,23,'CRATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304236,23,'CROATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304251,23,'CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304269,23,'DEPUTADO IRAPUAN PINHEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304277,23,'ERERÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304285,23,'EUSÉBIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304301,23,'FARIAS BRITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304350,23,'FORQUILHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304400,23,'FORTALEZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304459,23,'FORTIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304509,23,'FRECHEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304608,23,'GENERAL SAMPAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304657,23,'GRAÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304707,23,'GRANJA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304806,23,'GRANJEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304905,23,'GROAÍRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2304954,23,'GUAIÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305001,23,'GUARACIABA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305100,23,'GUARAMIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305209,23,'HIDROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305233,23,'HORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305266,23,'IBARETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305308,23,'IBIAPINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305332,23,'IBICUITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305357,23,'ICAPUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305407,23,'ICÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305506,23,'IGUATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305605,23,'INDEPENDÊNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305654,23,'IPAPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305704,23,'IPAUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305803,23,'IPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2305902,23,'IPUEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306009,23,'IRACEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306108,23,'IRAUÇUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306207,23,'ITAIÇABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306256,23,'ITAITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306306,23,'ITAPAGÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306405,23,'ITAPIPOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306504,23,'ITAPIÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306553,23,'ITAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306603,23,'ITATIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306702,23,'JAGUARETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306801,23,'JAGUARIBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2306900,23,'JAGUARIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307007,23,'JAGUARUANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307106,23,'JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307205,23,'JATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307254,23,'JIJOCA DE JERICOACOARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307304,23,'JUAZEIRO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307403,23,'JUCÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307502,23,'LAVRAS DA MANGABEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307601,23,'LIMOEIRO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307635,23,'MADALENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307650,23,'MARACANAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307700,23,'MARANGUAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307809,23,'MARCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2307908,23,'MARTINÓPOLE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308005,23,'MASSAPÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308104,23,'MAURITI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308203,23,'MERUOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308302,23,'MILAGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308351,23,'MILHÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308377,23,'MIRAÍMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308401,23,'MISSÃO VELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308500,23,'MOMBAÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308609,23,'MONSENHOR TABOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308708,23,'MORADA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308807,23,'MORAÚJO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2308906,23,'MORRINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309003,23,'MUCAMBO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309102,23,'MULUNGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309201,23,'NOVA OLINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309300,23,'NOVA RUSSAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309409,23,'NOVO ORIENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309458,23,'OCARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309508,23,'ORÓS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309607,23,'PACAJUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309706,23,'PACATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309805,23,'PACOTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2309904,23,'PACUJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310001,23,'PALHANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310100,23,'PALMÁCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310209,23,'PARACURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310258,23,'PARAIPABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310308,23,'PARAMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310407,23,'PARAMOTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310506,23,'PEDRA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310605,23,'PENAFORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310704,23,'PENTECOSTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310803,23,'PEREIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310852,23,'PINDORETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310902,23,'PIQUET CARNEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2310951,23,'PIRES FERREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311009,23,'PORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311108,23,'PORTEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311207,23,'POTENGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311231,23,'POTIRETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311264,23,'QUITERIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311306,23,'QUIXADÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311355,23,'QUIXELÔ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311405,23,'QUIXERAMOBIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311504,23,'QUIXERÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311603,23,'REDENÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311702,23,'RERIUTABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311801,23,'RUSSAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311900,23,'SABOEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2311959,23,'SALITRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312007,23,'SANTANA DO ACARAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312106,23,'SANTANA DO CARIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312205,23,'SANTA QUITÉRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312304,23,'SÃO BENEDITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312403,23,'SÃO GONÇALO DO AMARANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312502,23,'SÃO JOÃO DO JAGUARIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312601,23,'SÃO LUÍS DO CURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312700,23,'SENADOR POMPEU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312809,23,'SENADOR SÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2312908,23,'SOBRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313005,23,'SOLONÓPOLE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313104,23,'TABULEIRO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313203,23,'TAMBORIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313252,23,'TARRAFAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313302,23,'TAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313351,23,'TEJUÇUOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313401,23,'TIANGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313500,23,'TRAIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313559,23,'TURURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313609,23,'UBAJARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313708,23,'UMARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313757,23,'UMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313807,23,'URUBURETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313906,23,'URUOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2313955,23,'VARJOTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2314003,23,'VÁRZEA ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2314102,23,'VIÇOSA DO CEARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400109,24,'ACARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400208,24,'AÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400307,24,'AFONSO BEZERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400406,24,'ÁGUA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400505,24,'ALEXANDRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400604,24,'ALMINO AFONSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400703,24,'ALTO DO RODRIGUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400802,24,'ANGICOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2400901,24,'ANTÔNIO MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401008,24,'APODI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401107,24,'AREIA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401206,24,'ARÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401305,24,'AUGUSTO SEVERO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401404,24,'BAÍA FORMOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401453,24,'BARAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401503,24,'BARCELONA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401602,24,'BENTO FERNANDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401651,24,'BODÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401701,24,'BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401800,24,'BREJINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401859,24,'CAIÇARA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2401909,24,'CAIÇARA DO RIO DO VENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402006,24,'CAICÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402105,24,'CAMPO REDONDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402204,24,'CANGUARETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402303,24,'CARAÚBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402402,24,'CARNAÚBA DOS DANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402501,24,'CARNAUBAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402600,24,'CEARÁ-MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402709,24,'CERRO CORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402808,24,'CORONEL EZEQUIEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2402907,24,'CORONEL JOÃO PESSOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403004,24,'CRUZETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403103,24,'CURRAIS NOVOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403202,24,'DOUTOR SEVERIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403251,24,'PARNAMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403301,24,'ENCANTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403400,24,'EQUADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403509,24,'ESPÍRITO SANTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403608,24,'EXTREMOZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403707,24,'FELIPE GUERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403756,24,'FERNANDO PEDROZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403806,24,'FLORÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2403905,24,'FRANCISCO DANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404002,24,'FRUTUOSO GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404101,24,'GALINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404200,24,'GOIANINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404309,24,'GOVERNADOR DIX-SEPT ROSADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404408,24,'GROSSOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404507,24,'GUAMARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404606,24,'IELMO MARINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404705,24,'IPANGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404804,24,'IPUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404853,24,'ITAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2404903,24,'ITAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405009,24,'JAÇANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405108,24,'JANDAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405207,24,'JANDUÍS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405306,24,'JANUÁRIO CICCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405405,24,'JAPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405504,24,'JARDIM DE ANGICOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405603,24,'JARDIM DE PIRANHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405702,24,'JARDIM DO SERIDÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405801,24,'JOÃO CÂMARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2405900,24,'JOÃO DIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406007,24,'JOSÉ DA PENHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406106,24,'JUCURUTU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406155,24,'JUNDIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406205,24,'LAGOA D''ANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406304,24,'LAGOA DE PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406403,24,'LAGOA DE VELHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406502,24,'LAGOA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406601,24,'LAGOA SALGADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406700,24,'LAJES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406809,24,'LAJES PINTADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2406908,24,'LUCRÉCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407005,24,'LUÍS GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407104,24,'MACAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407203,24,'MACAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407252,24,'MAJOR SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407302,24,'MARCELINO VIEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407401,24,'MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407500,24,'MAXARANGUAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407609,24,'MESSIAS TARGINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407708,24,'MONTANHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407807,24,'MONTE ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2407906,24,'MONTE DAS GAMELEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408003,24,'MOSSORÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408102,24,'NATAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408201,24,'NÍSIA FLORESTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408300,24,'NOVA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408409,24,'OLHO-D''ÁGUA DO BORGES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408508,24,'OURO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408607,24,'PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408706,24,'PARAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408805,24,'PARAZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408904,24,'PARELHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2408953,24,'RIO DO FOGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409100,24,'PASSA E FICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409209,24,'PASSAGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409308,24,'PATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409332,24,'SANTA MARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409407,24,'PAU DOS FERROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409506,24,'PEDRA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409605,24,'PEDRA PRETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409704,24,'PEDRO AVELINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409803,24,'PEDRO VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2409902,24,'PENDÊNCIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410009,24,'PILÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410108,24,'POÇO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410207,24,'PORTALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410256,24,'PORTO DO MANGUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410306,24,'PRESIDENTE JUSCELINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410405,24,'PUREZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410504,24,'RAFAEL FERNANDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410603,24,'RAFAEL GODEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410702,24,'RIACHO DA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410801,24,'RIACHO DE SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2410900,24,'RIACHUELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411007,24,'RODOLFO FERNANDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411056,24,'TIBAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411106,24,'RUY BARBOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411205,24,'SANTA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411403,24,'SANTANA DO MATOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411429,24,'SANTANA DO SERIDÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411502,24,'SANTO ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411601,24,'SÃO BENTO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411700,24,'SÃO BENTO DO TRAIRÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411809,24,'SÃO FERNANDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2411908,24,'SÃO FRANCISCO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412005,24,'SÃO GONÇALO DO AMARANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412104,24,'SÃO JOÃO DO SABUGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412203,24,'SÃO JOSÉ DE MIPIBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412302,24,'SÃO JOSÉ DO CAMPESTRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412401,24,'SÃO JOSÉ DO SERIDÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412500,24,'SÃO MIGUEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412559,24,'SÃO MIGUEL DO GOSTOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412609,24,'SÃO PAULO DO POTENGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412708,24,'SÃO PEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412807,24,'SÃO RAFAEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2412906,24,'SÃO TOMÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413003,24,'SÃO VICENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413102,24,'SENADOR ELÓI DE SOUZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413201,24,'SENADOR GEORGINO AVELINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413300,24,'SERRA DE SÃO BENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413359,24,'SERRA DO MEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413409,24,'SERRA NEGRA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413508,24,'SERRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413557,24,'SERRINHA DOS PINTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413607,24,'SEVERIANO MELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413706,24,'SÍTIO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413805,24,'TABOLEIRO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2413904,24,'TAIPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414001,24,'TANGARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414100,24,'TENENTE ANANIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414159,24,'TENENTE LAURENTINO CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414209,24,'TIBAU DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414308,24,'TIMBAÚBA DOS BATISTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414407,24,'TOUROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414456,24,'TRIUNFO POTIGUAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414506,24,'UMARIZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414605,24,'UPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414704,24,'VÁRZEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414753,24,'VENHA-VER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414803,24,'VERA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2414902,24,'VIÇOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2415008,24,'VILA FLOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500106,25,'ÁGUA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500205,25,'AGUIAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500304,25,'ALAGOA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500403,25,'ALAGOA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500502,25,'ALAGOINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500536,25,'ALCANTIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500577,25,'ALGODÃO DE JANDAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500601,25,'ALHANDRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500700,25,'SÃO JOÃO DO RIO DO PEIXE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500734,25,'AMPARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500775,25,'APARECIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500809,25,'ARAÇAGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2500908,25,'ARARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501005,25,'ARARUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501104,25,'AREIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501153,25,'AREIA DE BARAÚNAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501203,25,'AREIAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501302,25,'AROEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501351,25,'ASSUNÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501401,25,'BAÍA DA TRAIÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501500,25,'BANANEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501534,25,'BARAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501575,25,'BARRA DE SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501609,25,'BARRA DE SANTA ROSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501708,25,'BARRA DE SÃO MIGUEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501807,25,'BAYEUX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2501906,25,'BELÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502003,25,'BELÉM DO BREJO DO CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502052,25,'BERNARDINO BATISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502102,25,'BOA VENTURA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502151,25,'BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502201,25,'BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502300,25,'BOM SUCESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502409,25,'BONITO DE SANTA FÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502508,25,'BOQUEIRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502607,25,'IGARACY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502706,25,'BORBOREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502805,25,'BREJO DO CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2502904,25,'BREJO DOS SANTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503001,25,'CAAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503100,25,'CABACEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503209,25,'CABEDELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503308,25,'CACHOEIRA DOS ÍNDIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503407,25,'CACIMBA DE AREIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503506,25,'CACIMBA DE DENTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503555,25,'CACIMBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503605,25,'CAIÇARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503704,25,'CAJAZEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503753,25,'CAJAZEIRINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503803,25,'CALDAS BRANDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2503902,25,'CAMALAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504009,25,'CAMPINA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504033,25,'CAPIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504074,25,'CARAÚBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504108,25,'CARRAPATEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504157,25,'CASSERENGUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504207,25,'CATINGUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504306,25,'CATOLÉ DO ROCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504355,25,'CATURITÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504405,25,'CONCEIÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504504,25,'CONDADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504603,25,'CONDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504702,25,'CONGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504801,25,'COREMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504850,25,'COXIXOLA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2504900,25,'CRUZ DO ESPÍRITO SANTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505006,25,'CUBATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505105,25,'CUITÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505204,25,'CUITEGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505238,25,'CUITÉ DE MAMANGUAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505279,25,'CURRAL DE CIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505303,25,'CURRAL VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505352,25,'DAMIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505402,25,'DESTERRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505501,25,'VISTA SERRANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505600,25,'DIAMANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505709,25,'DONA INÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505808,25,'DUAS ESTRADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2505907,25,'EMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506004,25,'ESPERANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506103,25,'FAGUNDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506202,25,'FREI MARTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506251,25,'GADO BRAVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506301,25,'GUARABIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506400,25,'GURINHÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506509,25,'GURJÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506608,25,'IBIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506707,25,'IMACULADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506806,25,'INGÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2506905,25,'ITABAIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507002,25,'ITAPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507101,25,'ITAPOROROCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507200,25,'ITATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507309,25,'JACARAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507408,25,'JERICÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507507,25,'JOÃO PESSOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507606,25,'JUAREZ TÁVORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507705,25,'JUAZEIRINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507804,25,'JUNCO DO SERIDÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2507903,25,'JURIPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508000,25,'JURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508109,25,'LAGOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508208,25,'LAGOA DE DENTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508307,25,'LAGOA SECA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508406,25,'LASTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508505,25,'LIVRAMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508554,25,'LOGRADOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508604,25,'LUCENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508703,25,'MÃE D''ÁGUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508802,25,'MALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2508901,25,'MAMANGUAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509008,25,'MANAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509057,25,'MARCAÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509107,25,'MARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509156,25,'MARIZÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509206,25,'MASSARANDUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509305,25,'MATARACA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509339,25,'MATINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509370,25,'MATO GROSSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509396,25,'MATURÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509404,25,'MOGEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509503,25,'MONTADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509602,25,'MONTE HOREBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509701,25,'MONTEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509800,25,'MULUNGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2509909,25,'NATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510006,25,'NAZAREZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510105,25,'NOVA FLORESTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510204,25,'NOVA OLINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510303,25,'NOVA PALMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510402,25,'OLHO D''ÁGUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510501,25,'OLIVEDOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510600,25,'OURO VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510659,25,'PARARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510709,25,'PASSAGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510808,25,'PATOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2510907,25,'PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511004,25,'PEDRA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511103,25,'PEDRA LAVRADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511202,25,'PEDRAS DE FOGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511301,25,'PIANCÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511400,25,'PICUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511509,25,'PILAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511608,25,'PILÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511707,25,'PILÕEZINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511806,25,'PIRPIRITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2511905,25,'PITIMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512002,25,'POCINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512036,25,'POÇO DANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512077,25,'POÇO DE JOSÉ DE MOURA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512101,25,'POMBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512200,25,'PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512309,25,'PRINCESA ISABEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512408,25,'PUXINANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512507,25,'QUEIMADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512606,25,'QUIXABÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512705,25,'REMÍGIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512721,25,'PEDRO RÉGIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512747,25,'RIACHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512754,25,'RIACHÃO DO BACAMARTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512762,25,'RIACHÃO DO POÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512788,25,'RIACHO DE SANTO ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512804,25,'RIACHO DOS CAVALOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2512903,25,'RIO TINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513000,25,'SALGADINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513109,25,'SALGADO DE SÃO FÉLIX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513158,25,'SANTA CECÍLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513208,25,'SANTA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513307,25,'SANTA HELENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513356,25,'SANTA INÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513406,25,'SANTA LUZIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513505,25,'SANTANA DE MANGUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513604,25,'SANTANA DOS GARROTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513653,25,'SANTARÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513703,25,'SANTA RITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513802,25,'SANTA TERESINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513851,25,'SANTO ANDRÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513901,25,'SÃO BENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513927,25,'SÃO BENTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513943,25,'SÃO DOMINGOS DO CARIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513968,25,'SÃO DOMINGOS DE POMBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2513984,25,'SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514008,25,'SÃO JOÃO DO CARIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514107,25,'SÃO JOÃO DO TIGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514206,25,'SÃO JOSÉ DA LAGOA TAPADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514305,25,'SÃO JOSÉ DE CAIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514404,25,'SÃO JOSÉ DE ESPINHARAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514453,25,'SÃO JOSÉ DOS RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514503,25,'SÃO JOSÉ DE PIRANHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514552,25,'SÃO JOSÉ DE PRINCESA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514602,25,'SÃO JOSÉ DO BONFIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514651,25,'SÃO JOSÉ DO BREJO DO CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514701,25,'SÃO JOSÉ DO SABUGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514800,25,'SÃO JOSÉ DOS CORDEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2514909,25,'SÃO MAMEDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515005,25,'SÃO MIGUEL DE TAIPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515104,25,'SÃO SEBASTIÃO DE LAGOA DE ROÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515203,25,'SÃO SEBASTIÃO DO UMBUZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515302,25,'SAPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515401,25,'SERIDÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515500,25,'SERRA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515609,25,'SERRA DA RAIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515708,25,'SERRA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515807,25,'SERRA REDONDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515906,25,'SERRARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515930,25,'SERTÃOZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2515971,25,'SOBRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516003,25,'SOLÂNEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516102,25,'SOLEDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516151,25,'SOSSÊGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516201,25,'SOUSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516300,25,'SUMÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516409,25,'CAMPO DE SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516508,25,'TAPEROÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516607,25,'TAVARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516706,25,'TEIXEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516755,25,'TENÓRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516805,25,'TRIUNFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2516904,25,'UIRAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2517001,25,'UMBUZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2517100,25,'VÁRZEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2517209,25,'VIEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2517407,25,'ZABELÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600054,26,'ABREU E LIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600104,26,'AFOGADOS DA INGAZEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600203,26,'AFRÂNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600302,26,'AGRESTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600401,26,'ÁGUA PRETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600500,26,'ÁGUAS BELAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600609,26,'ALAGOINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600708,26,'ALIANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600807,26,'ALTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2600906,26,'AMARAJI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601003,26,'ANGELIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601052,26,'ARAÇOIABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601102,26,'ARARIPINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601201,26,'ARCOVERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601300,26,'BARRA DE GUABIRABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601409,26,'BARREIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601508,26,'BELÉM DE MARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601607,26,'BELÉM DE SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601706,26,'BELO JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601805,26,'BETÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2601904,26,'BEZERROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602001,26,'BODOCÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602100,26,'BOM CONSELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602209,26,'BOM JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602308,26,'BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602407,26,'BREJÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602506,26,'BREJINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602605,26,'BREJO DA MADRE DE DEUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602704,26,'BUENOS AIRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602803,26,'BUÍQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2602902,26,'CABO DE SANTO AGOSTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603009,26,'CABROBÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603108,26,'CACHOEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603207,26,'CAETÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603306,26,'CALÇADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603405,26,'CALUMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603454,26,'CAMARAGIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603504,26,'CAMOCIM DE SÃO FÉLIX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603603,26,'CAMUTANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603702,26,'CANHOTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603801,26,'CAPOEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603900,26,'CARNAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2603926,26,'CARNAUBEIRA DA PENHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604007,26,'CARPINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604106,26,'CARUARU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604155,26,'CASINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604205,26,'CATENDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604304,26,'CEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604403,26,'CHÃ DE ALEGRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604502,26,'CHÃ GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604601,26,'CONDADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604700,26,'CORRENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604809,26,'CORTÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2604908,26,'CUMARU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605004,26,'CUPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605103,26,'CUSTÓDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605152,26,'DORMENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605202,26,'ESCADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605301,26,'EXU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605400,26,'FEIRA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605459,26,'FERNANDO DE NORONHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605509,26,'FERREIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605608,26,'FLORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605707,26,'FLORESTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605806,26,'FREI MIGUELINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2605905,26,'GAMELEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606002,26,'GARANHUNS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606101,26,'GLÓRIA DO GOITÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606200,26,'GOIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606309,26,'GRANITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606408,26,'GRAVATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606507,26,'IATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606606,26,'IBIMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606705,26,'IBIRAJUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606804,26,'IGARASSU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2606903,26,'IGUARACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607000,26,'INAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607109,26,'INGAZEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607208,26,'IPOJUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607307,26,'IPUBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607406,26,'ITACURUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607505,26,'ITAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607604,26,'ILHA DE ITAMARACÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607653,26,'ITAMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607703,26,'ITAPETIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607752,26,'ITAPISSUMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607802,26,'ITAQUITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607901,26,'JABOATÃO DOS GUARARAPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2607950,26,'JAQUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608008,26,'JATAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608057,26,'JATOBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608107,26,'JOÃO ALFREDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608206,26,'JOAQUIM NABUCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608255,26,'JUCATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608305,26,'JUPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608404,26,'JUREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608453,26,'LAGOA DO CARRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608503,26,'LAGOA DO ITAENGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608602,26,'LAGOA DO OURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608701,26,'LAGOA DOS GATOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608750,26,'LAGOA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608800,26,'LAJEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2608909,26,'LIMOEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609006,26,'MACAPARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609105,26,'MACHADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609154,26,'MANARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609204,26,'MARAIAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609303,26,'MIRANDIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609402,26,'MORENO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609501,26,'NAZARÉ DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609600,26,'OLINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609709,26,'OROBÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609808,26,'OROCÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2609907,26,'OURICURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610004,26,'PALMARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610103,26,'PALMEIRINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610202,26,'PANELAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610301,26,'PARANATAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610400,26,'PARNAMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610509,26,'PASSIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610608,26,'PAUDALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610707,26,'PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610806,26,'PEDRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2610905,26,'PESQUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611002,26,'PETROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611101,26,'PETROLINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611200,26,'POÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611309,26,'POMBOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611408,26,'PRIMAVERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611507,26,'QUIPAPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611533,26,'QUIXABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611606,26,'RECIFE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611705,26,'RIACHO DAS ALMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611804,26,'RIBEIRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2611903,26,'RIO FORMOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612000,26,'SAIRÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612109,26,'SALGADINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612208,26,'SALGUEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612307,26,'SALOÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612406,26,'SANHARÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612455,26,'SANTA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612471,26,'SANTA CRUZ DA BAIXA VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612505,26,'SANTA CRUZ DO CAPIBARIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612554,26,'SANTA FILOMENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612604,26,'SANTA MARIA DA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612703,26,'SANTA MARIA DO CAMBUCÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612802,26,'SANTA TEREZINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2612901,26,'SÃO BENEDITO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613008,26,'SÃO BENTO DO UNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613107,26,'SÃO CAITANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613206,26,'SÃO JOÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613305,26,'SÃO JOAQUIM DO MONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613404,26,'SÃO JOSÉ DA COROA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613503,26,'SÃO JOSÉ DO BELMONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613602,26,'SÃO JOSÉ DO EGITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613701,26,'SÃO LOURENÇO DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613800,26,'SÃO VICENTE FERRER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2613909,26,'SERRA TALHADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614006,26,'SERRITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614105,26,'SERTÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614204,26,'SIRINHAÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614303,26,'MOREILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614402,26,'SOLIDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614501,26,'SURUBIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614600,26,'TABIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614709,26,'TACAIMBÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614808,26,'TACARATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2614857,26,'TAMANDARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615003,26,'TAQUARITINGA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615102,26,'TEREZINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615201,26,'TERRA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615300,26,'TIMBAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615409,26,'TORITAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615508,26,'TRACUNHAÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615607,26,'TRINDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615706,26,'TRIUNFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615805,26,'TUPANATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2615904,26,'TUPARETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616001,26,'VENTUROSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616100,26,'VERDEJANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616183,26,'VERTENTE DO LÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616209,26,'VERTENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616308,26,'VICÊNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616407,26,'VITÓRIA DE SANTO ANTÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2616506,26,'XEXÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700102,27,'ÁGUA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700201,27,'ANADIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700300,27,'ARAPIRACA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700409,27,'ATALAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700508,27,'BARRA DE SANTO ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700607,27,'BARRA DE SÃO MIGUEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700706,27,'BATALHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700805,27,'BELÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2700904,27,'BELO MONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701001,27,'BOCA DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701100,27,'BRANQUINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701209,27,'CACIMBINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701308,27,'CAJUEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701357,27,'CAMPESTRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701407,27,'CAMPO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701506,27,'CAMPO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701605,27,'CANAPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701704,27,'CAPELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701803,27,'CARNEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2701902,27,'CHÃ PRETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702009,27,'COITÉ DO NÓIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702108,27,'COLÔNIA LEOPOLDINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702207,27,'COQUEIRO SECO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702306,27,'CORURIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702355,27,'CRAÍBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702405,27,'DELMIRO GOUVEIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702504,27,'DOIS RIACHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702553,27,'ESTRELA DE ALAGOAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702603,27,'FEIRA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702702,27,'FELIZ DESERTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702801,27,'FLEXEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2702900,27,'GIRAU DO PONCIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703007,27,'IBATEGUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703106,27,'IGACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703205,27,'IGREJA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703304,27,'INHAPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703403,27,'JACARÉ DOS HOMENS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703502,27,'JACUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703601,27,'JAPARATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703700,27,'JARAMATAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703759,27,'JEQUIÁ DA PRAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703809,27,'JOAQUIM GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2703908,27,'JUNDIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704005,27,'JUNQUEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704104,27,'LAGOA DA CANOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704203,27,'LIMOEIRO DE ANADIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704302,27,'MACEIÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704401,27,'MAJOR ISIDORO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704500,27,'MARAGOGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704609,27,'MARAVILHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704708,27,'MARECHAL DEODORO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704807,27,'MARIBONDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2704906,27,'MAR VERMELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705002,27,'MATA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705101,27,'MATRIZ DE CAMARAGIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705200,27,'MESSIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705309,27,'MINADOR DO NEGRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705408,27,'MONTEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705507,27,'MURICI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705606,27,'NOVO LINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705705,27,'OLHO D''ÁGUA DAS FLORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705804,27,'OLHO D''ÁGUA DO CASADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2705903,27,'OLHO D''ÁGUA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706000,27,'OLIVENÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706109,27,'OURO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706208,27,'PALESTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706307,27,'PALMEIRA DOS ÍNDIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706406,27,'PÃO DE AÇÚCAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706422,27,'PARICONHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706448,27,'PARIPUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706505,27,'PASSO DE CAMARAGIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706604,27,'PAULO JACINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706703,27,'PENEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706802,27,'PIAÇABUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2706901,27,'PILAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707008,27,'PINDOBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707107,27,'PIRANHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707206,27,'POÇO DAS TRINCHEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707305,27,'PORTO CALVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707404,27,'PORTO DE PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707503,27,'PORTO REAL DO COLÉGIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707602,27,'QUEBRANGULO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707701,27,'RIO LARGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707800,27,'ROTEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2707909,27,'SANTA LUZIA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708006,27,'SANTANA DO IPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708105,27,'SANTANA DO MUNDAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708204,27,'SÃO BRÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708303,27,'SÃO JOSÉ DA LAJE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708402,27,'SÃO JOSÉ DA TAPERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708501,27,'SÃO LUÍS DO QUITUNDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708600,27,'SÃO MIGUEL DOS CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708709,27,'SÃO MIGUEL DOS MILAGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708808,27,'SÃO SEBASTIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708907,27,'SATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2708956,27,'SENADOR RUI PALMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2709004,27,'TANQUE D''ARCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2709103,27,'TAQUARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2709152,27,'TEOTÔNIO VILELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2709202,27,'TRAIPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2709301,27,'UNIÃO DOS PALMARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2709400,27,'VIÇOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800100,28,'AMPARO DE SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800209,28,'AQUIDABÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800308,28,'ARACAJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800407,28,'ARAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800506,28,'AREIA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800605,28,'BARRA DOS COQUEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800670,28,'BOQUIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2800704,28,'BREJO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801009,28,'CAMPO DO BRITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801108,28,'CANHOBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801207,28,'CANINDÉ DE SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801306,28,'CAPELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801405,28,'CARIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801504,28,'CARMÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801603,28,'CEDRO DE SÃO JOÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801702,28,'CRISTINÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2801900,28,'CUMBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802007,28,'DIVINA PASTORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802106,28,'ESTÂNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802205,28,'FEIRA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802304,28,'FREI PAULO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802403,28,'GARARU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802502,28,'GENERAL MAYNARD');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802601,28,'GRACHO CARDOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802700,28,'ILHA DAS FLORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802809,28,'INDIAROBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2802908,28,'ITABAIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803005,28,'ITABAIANINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803104,28,'ITABI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803203,28,'ITAPORANGA D''AJUDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803302,28,'JAPARATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803401,28,'JAPOATÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803500,28,'LAGARTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803609,28,'LARANJEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803708,28,'MACAMBIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803807,28,'MALHADA DOS BOIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2803906,28,'MALHADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804003,28,'MARUIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804102,28,'MOITA BONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804201,28,'MONTE ALEGRE DE SERGIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804300,28,'MURIBECA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804409,28,'NEÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804458,28,'NOSSA SENHORA APARECIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804508,28,'NOSSA SENHORA DA GLÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804607,28,'NOSSA SENHORA DAS DORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804706,28,'NOSSA SENHORA DE LOURDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804805,28,'NOSSA SENHORA DO SOCORRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2804904,28,'PACATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805000,28,'PEDRA MOLE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805109,28,'PEDRINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805208,28,'PINHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805307,28,'PIRAMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805406,28,'POÇO REDONDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805505,28,'POÇO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805604,28,'PORTO DA FOLHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805703,28,'PROPRIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805802,28,'RIACHÃO DO DANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2805901,28,'RIACHUELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806008,28,'RIBEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806107,28,'ROSÁRIO DO CATETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806206,28,'SALGADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806305,28,'SANTA LUZIA DO ITANHY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806404,28,'SANTANA DO SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806503,28,'SANTA ROSA DE LIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806602,28,'SANTO AMARO DAS BROTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806701,28,'SÃO CRISTÓVÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806800,28,'SÃO DOMINGOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2806909,28,'SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807006,28,'SÃO MIGUEL DO ALEIXO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807105,28,'SIMÃO DIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807204,28,'SIRIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807303,28,'TELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807402,28,'TOBIAS BARRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807501,28,'TOMAR DO GERU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2807600,28,'UMBAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900108,29,'ABAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900207,29,'ABARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900306,29,'ACAJUTIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900355,29,'ADUSTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900405,29,'ÁGUA FRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900504,29,'ÉRICO CARDOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900603,29,'AIQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900702,29,'ALAGOINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900801,29,'ALCOBAÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2900900,29,'ALMADINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901007,29,'AMARGOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901106,29,'AMÉLIA RODRIGUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901155,29,'AMÉRICA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901205,29,'ANAGÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901304,29,'ANDARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901353,29,'ANDORINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901403,29,'ANGICAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901502,29,'ANGUERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901601,29,'ANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901700,29,'ANTÔNIO CARDOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901809,29,'ANTÔNIO GONÇALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901908,29,'APORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2901957,29,'APUAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902005,29,'ARACATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902054,29,'ARAÇAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902104,29,'ARACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902203,29,'ARAMARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902252,29,'ARATACA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902302,29,'ARATUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902401,29,'AURELINO LEAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902500,29,'BAIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902609,29,'BAIXA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902658,29,'BANZAÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902708,29,'BARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902807,29,'BARRA DA ESTIVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2902906,29,'BARRA DO CHOÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903003,29,'BARRA DO MENDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903102,29,'BARRA DO ROCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903201,29,'BARREIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903235,29,'BARRO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903276,29,'BARROCAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903300,29,'BARRO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903409,29,'BELMONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903508,29,'BELO CAMPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903607,29,'BIRITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903706,29,'BOA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903805,29,'BOA VISTA DO TUPIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903904,29,'BOM JESUS DA LAPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2903953,29,'BOM JESUS DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904001,29,'BONINAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904050,29,'BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904100,29,'BOQUIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904209,29,'BOTUPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904308,29,'BREJÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904407,29,'BREJOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904506,29,'BROTAS DE MACAÚBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904605,29,'BRUMADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904704,29,'BUERAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904753,29,'BURITIRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904803,29,'CAATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904852,29,'CABACEIRAS DO PARAGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2904902,29,'CACHOEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905008,29,'CACULÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905107,29,'CAÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905156,29,'CAETANOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905206,29,'CAETITÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905305,29,'CAFARNAUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905404,29,'CAIRU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905503,29,'CALDEIRÃO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905602,29,'CAMACAN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905701,29,'CAMAÇARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905800,29,'CAMAMU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2905909,29,'CAMPO ALEGRE DE LOURDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906006,29,'CAMPO FORMOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906105,29,'CANÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906204,29,'CANARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906303,29,'CANAVIEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906402,29,'CANDEAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906501,29,'CANDEIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906600,29,'CANDIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906709,29,'CÂNDIDO SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906808,29,'CANSANÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906824,29,'CANUDOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906857,29,'CAPELA DO ALTO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906873,29,'CAPIM GROSSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906899,29,'CARAÍBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2906907,29,'CARAVELAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907004,29,'CARDEAL DA SILVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907103,29,'CARINHANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907202,29,'CASA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907301,29,'CASTRO ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907400,29,'CATOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907509,29,'CATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907558,29,'CATURAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907608,29,'CENTRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907707,29,'CHORROCHÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907806,29,'CÍCERO DANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2907905,29,'CIPÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908002,29,'COARACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908101,29,'COCOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908200,29,'CONCEIÇÃO DA FEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908309,29,'CONCEIÇÃO DO ALMEIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908408,29,'CONCEIÇÃO DO COITÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908507,29,'CONCEIÇÃO DO JACUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908606,29,'CONDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908705,29,'CONDEÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908804,29,'CONTENDAS DO SINCORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2908903,29,'CORAÇÃO DE MARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909000,29,'CORDEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909109,29,'CORIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909208,29,'CORONEL JOÃO SÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909307,29,'CORRENTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909406,29,'COTEGIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909505,29,'CRAVOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909604,29,'CRISÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909703,29,'CRISTÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909802,29,'CRUZ DAS ALMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2909901,29,'CURAÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910008,29,'DÁRIO MEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910057,29,'DIAS D''ÁVILA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910107,29,'DOM BASÍLIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910206,29,'DOM MACEDO COSTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910305,29,'ELÍSIO MEDRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910404,29,'ENCRUZILHADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910503,29,'ENTRE RIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910602,29,'ESPLANADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910701,29,'EUCLIDES DA CUNHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910727,29,'EUNÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910750,29,'FÁTIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910776,29,'FEIRA DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910800,29,'FEIRA DE SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910859,29,'FILADÉLFIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2910909,29,'FIRMINO ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911006,29,'FLORESTA AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911105,29,'FORMOSA DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911204,29,'GANDU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911253,29,'GAVIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911303,29,'GENTIO DO OURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911402,29,'GLÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911501,29,'GONGOGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911600,29,'GOVERNADOR MANGABEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911659,29,'GUAJERU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911709,29,'GUANAMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911808,29,'GUARATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911857,29,'HELIÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2911907,29,'IAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912004,29,'IBIASSUCÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912103,29,'IBICARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912202,29,'IBICOARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912301,29,'IBICUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912400,29,'IBIPEBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912509,29,'IBIPITANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912608,29,'IBIQUERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912707,29,'IBIRAPITANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912806,29,'IBIRAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2912905,29,'IBIRATAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913002,29,'IBITIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913101,29,'IBITITÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913200,29,'IBOTIRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913309,29,'ICHU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913408,29,'IGAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913457,29,'IGRAPIÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913507,29,'IGUAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913606,29,'ILHÉUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913705,29,'INHAMBUPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913804,29,'IPECAETÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2913903,29,'IPIAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914000,29,'IPIRÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914109,29,'IPUPIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914208,29,'IRAJUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914307,29,'IRAMAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914406,29,'IRAQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914505,29,'IRARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914604,29,'IRECÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914653,29,'ITABELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914703,29,'ITABERABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914802,29,'ITABUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2914901,29,'ITACARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915007,29,'ITAETÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915106,29,'ITAGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915205,29,'ITAGIBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915304,29,'ITAGIMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915353,29,'ITAGUAÇU DA BAHIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915403,29,'ITAJU DO COLÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915502,29,'ITAJUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915601,29,'ITAMARAJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915700,29,'ITAMARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915809,29,'ITAMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2915908,29,'ITANAGRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916005,29,'ITANHÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916104,29,'ITAPARICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916203,29,'ITAPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916302,29,'ITAPEBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916401,29,'ITAPETINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916500,29,'ITAPICURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916609,29,'ITAPITANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916708,29,'ITAQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916807,29,'ITARANTIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916856,29,'ITATIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2916906,29,'ITIRUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917003,29,'ITIÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917102,29,'ITORORÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917201,29,'ITUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917300,29,'ITUBERÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917334,29,'IUIÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917359,29,'JABORANDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917409,29,'JACARACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917508,29,'JACOBINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917607,29,'JAGUAQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917706,29,'JAGUARARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917805,29,'JAGUARIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2917904,29,'JANDAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918001,29,'JEQUIÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918100,29,'JEREMOABO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918209,29,'JIQUIRIÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918308,29,'JITAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918357,29,'JOÃO DOURADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918407,29,'JUAZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918456,29,'JUCURUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918506,29,'JUSSARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918555,29,'JUSSARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918605,29,'JUSSIAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918704,29,'LAFAIETE COUTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918753,29,'LAGOA REAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918803,29,'LAJE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2918902,29,'LAJEDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919009,29,'LAJEDINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919058,29,'LAJEDO DO TABOCAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919108,29,'LAMARÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919157,29,'LAPÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919207,29,'LAURO DE FREITAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919306,29,'LENÇÓIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919405,29,'LICÍNIO DE ALMEIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919504,29,'LIVRAMENTO DE NOSSA SENHORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919553,29,'LUÍS EDUARDO MAGALHÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919603,29,'MACAJUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919702,29,'MACARANI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919801,29,'MACAÚBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919900,29,'MACURURÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919926,29,'MADRE DE DEUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2919959,29,'MAETINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920007,29,'MAIQUINIQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920106,29,'MAIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920205,29,'MALHADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920304,29,'MALHADA DE PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920403,29,'MANOEL VITORINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920452,29,'MANSIDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920502,29,'MARACÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920601,29,'MARAGOGIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920700,29,'MARAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920809,29,'MARCIONÍLIO SOUZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2920908,29,'MASCOTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921005,29,'MATA DE SÃO JOÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921054,29,'MATINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921104,29,'MEDEIROS NETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921203,29,'MIGUEL CALMON');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921302,29,'MILAGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921401,29,'MIRANGABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921450,29,'MIRANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921500,29,'MONTE SANTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921609,29,'MORPARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921708,29,'MORRO DO CHAPÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921807,29,'MORTUGABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2921906,29,'MUCUGÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922003,29,'MUCURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922052,29,'MULUNGU DO MORRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922102,29,'MUNDO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922201,29,'MUNIZ FERREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922250,29,'MUQUÉM DE SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922300,29,'MURITIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922409,29,'MUTUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922508,29,'NAZARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922607,29,'NILO PEÇANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922656,29,'NORDESTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922706,29,'NOVA CANAÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922730,29,'NOVA FÁTIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922755,29,'NOVA IBIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922805,29,'NOVA ITARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922854,29,'NOVA REDENÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2922904,29,'NOVA SOURE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923001,29,'NOVA VIÇOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923035,29,'NOVO HORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923050,29,'NOVO TRIUNFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923100,29,'OLINDINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923209,29,'OLIVEIRA DOS BREJINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923308,29,'OURIÇANGAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923357,29,'OUROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923407,29,'PALMAS DE MONTE ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923506,29,'PALMEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923605,29,'PARAMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923704,29,'PARATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923803,29,'PARIPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2923902,29,'PAU BRASIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924009,29,'PAULO AFONSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924058,29,'PÉ DE SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924108,29,'PEDRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924207,29,'PEDRO ALEXANDRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924306,29,'PIATÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924405,29,'PILÃO ARCADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924504,29,'PINDAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924603,29,'PINDOBAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924652,29,'PINTADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924678,29,'PIRAÍ DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924702,29,'PIRIPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924801,29,'PIRITIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2924900,29,'PLANALTINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925006,29,'PLANALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925105,29,'POÇÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925204,29,'POJUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925253,29,'PONTO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925303,29,'PORTO SEGURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925402,29,'POTIRAGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925501,29,'PRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925600,29,'PRESIDENTE DUTRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925709,29,'PRESIDENTE JÂNIO QUADROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925758,29,'PRESIDENTE TANCREDO NEVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925808,29,'QUEIMADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925907,29,'QUIJINGUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925931,29,'QUIXABEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2925956,29,'RAFAEL JAMBEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926004,29,'REMANSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926103,29,'RETIROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926202,29,'RIACHÃO DAS NEVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926301,29,'RIACHÃO DO JACUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926400,29,'RIACHO DE SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926509,29,'RIBEIRA DO AMPARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926608,29,'RIBEIRA DO POMBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926657,29,'RIBEIRÃO DO LARGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926707,29,'RIO DE CONTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926806,29,'RIO DO ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2926905,29,'RIO DO PIRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927002,29,'RIO REAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927101,29,'RODELAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927200,29,'RUY BARBOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927309,29,'SALINAS DA MARGARIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927408,29,'SALVADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927507,29,'SANTA BÁRBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927606,29,'SANTA BRÍGIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927705,29,'SANTA CRUZ CABRÁLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927804,29,'SANTA CRUZ DA VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2927903,29,'SANTA INÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928000,29,'SANTALUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928059,29,'SANTA LUZIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928109,29,'SANTA MARIA DA VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928208,29,'SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928307,29,'SANTANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928406,29,'SANTA RITA DE CÁSSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928505,29,'SANTA TERESINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928604,29,'SANTO AMARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928703,29,'SANTO ANTÔNIO DE JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928802,29,'SANTO ESTÊVÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928901,29,'SÃO DESIDÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2928950,29,'SÃO DOMINGOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929008,29,'SÃO FÉLIX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929057,29,'SÃO FÉLIX DO CORIBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929107,29,'SÃO FELIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929206,29,'SÃO FRANCISCO DO CONDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929255,29,'SÃO GABRIEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929305,29,'SÃO GONÇALO DOS CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929354,29,'SÃO JOSÉ DA VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929370,29,'SÃO JOSÉ DO JACUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929404,29,'SÃO MIGUEL DAS MATAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929503,29,'SÃO SEBASTIÃO DO PASSÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929602,29,'SAPEAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929701,29,'SÁTIRO DIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929750,29,'SAUBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929800,29,'SAÚDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2929909,29,'SEABRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930006,29,'SEBASTIÃO LARANJEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930105,29,'SENHOR DO BONFIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930154,29,'SERRA DO RAMALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930204,29,'SENTO SÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930303,29,'SERRA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930402,29,'SERRA PRETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930501,29,'SERRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930600,29,'SERROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930709,29,'SIMÕES FILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930758,29,'SÍTIO DO MATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930766,29,'SÍTIO DO QUINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930774,29,'SOBRADINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930808,29,'SOUTO SOARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2930907,29,'TABOCAS DO BREJO VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931004,29,'TANHAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931053,29,'TANQUE NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931103,29,'TANQUINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931202,29,'TAPEROÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931301,29,'TAPIRAMUTÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931350,29,'TEIXEIRA DE FREITAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931400,29,'TEODORO SAMPAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931509,29,'TEOFILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931608,29,'TEOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931707,29,'TERRA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931806,29,'TREMEDAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2931905,29,'TUCANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932002,29,'UAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932101,29,'UBAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932200,29,'UBAITABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932309,29,'UBATÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932408,29,'UIBAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932457,29,'UMBURANAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932507,29,'UNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932606,29,'URANDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932705,29,'URUÇUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932804,29,'UTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2932903,29,'VALENÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933000,29,'VALENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933059,29,'VÁRZEA DA ROÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933109,29,'VÁRZEA DO POÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933158,29,'VÁRZEA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933174,29,'VARZEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933208,29,'VERA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933257,29,'VEREDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933307,29,'VITÓRIA DA CONQUISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933406,29,'WAGNER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933455,29,'WANDERLEY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933505,29,'WENCESLAU GUIMARÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (2933604,29,'XIQUE-XIQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100104,31,'ABADIA DOS DOURADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100203,31,'ABAETÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100302,31,'ABRE CAMPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100401,31,'ACAIACA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100500,31,'AÇUCENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100609,31,'ÁGUA BOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100708,31,'ÁGUA COMPRIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100807,31,'AGUANIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3100906,31,'ÁGUAS FORMOSAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101003,31,'ÁGUAS VERMELHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101102,31,'AIMORÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101201,31,'AIURUOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101300,31,'ALAGOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101409,31,'ALBERTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101508,31,'ALÉM PARAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101607,31,'ALFENAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101631,31,'ALFREDO VASCONCELOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101706,31,'ALMENARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101805,31,'ALPERCATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3101904,31,'ALPINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102001,31,'ALTEROSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102050,31,'ALTO CAPARAÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102100,31,'ALTO RIO DOCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102209,31,'ALVARENGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102308,31,'ALVINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102407,31,'ALVORADA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102506,31,'AMPARO DO SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102605,31,'ANDRADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102704,31,'CACHOEIRA DE PAJEÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102803,31,'ANDRELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102852,31,'ANGELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3102902,31,'ANTÔNIO CARLOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103009,31,'ANTÔNIO DIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103108,31,'ANTÔNIO PRADO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103207,31,'ARAÇAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103306,31,'ARACITABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103405,31,'ARAÇUAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103504,31,'ARAGUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103603,31,'ARANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103702,31,'ARAPONGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103751,31,'ARAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103801,31,'ARAPUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3103900,31,'ARAÚJOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104007,31,'ARAXÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104106,31,'ARCEBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104205,31,'ARCOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104304,31,'AREADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104403,31,'ARGIRITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104452,31,'ARICANDUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104502,31,'ARINOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104601,31,'ASTOLFO DUTRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104700,31,'ATALÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104809,31,'AUGUSTO DE LIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3104908,31,'BAEPENDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105004,31,'BALDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105103,31,'BAMBUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105202,31,'BANDEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105301,31,'BANDEIRA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105400,31,'BARÃO DE COCAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105509,31,'BARÃO DE MONTE ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105608,31,'BARBACENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105707,31,'BARRA LONGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3105905,31,'BARROSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106002,31,'BELA VISTA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106101,31,'BELMIRO BRAGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106200,31,'BELO HORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106309,31,'BELO ORIENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106408,31,'BELO VALE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106507,31,'BERILO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106606,31,'BERTÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106655,31,'BERIZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106705,31,'BETIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106804,31,'BIAS FORTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3106903,31,'BICAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107000,31,'BIQUINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107109,31,'BOA ESPERANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107208,31,'BOCAINA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107307,31,'BOCAIÚVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107406,31,'BOM DESPACHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107505,31,'BOM JARDIM DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107604,31,'BOM JESUS DA PENHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107703,31,'BOM JESUS DO AMPARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107802,31,'BOM JESUS DO GALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3107901,31,'BOM REPOUSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108008,31,'BOM SUCESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108107,31,'BONFIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108206,31,'BONFINÓPOLIS DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108255,31,'BONITO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108305,31,'BORDA DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108404,31,'BOTELHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108503,31,'BOTUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108552,31,'BRASILÂNDIA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108602,31,'BRASÍLIA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108701,31,'BRÁS PIRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108800,31,'BRAÚNAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3108909,31,'BRASÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109006,31,'BRUMADINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109105,31,'BUENO BRANDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109204,31,'BUENÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109253,31,'BUGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109303,31,'BURITIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109402,31,'BURITIZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109451,31,'CABECEIRA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109501,31,'CABO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109600,31,'CACHOEIRA DA PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109709,31,'CACHOEIRA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109808,31,'CACHOEIRA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3109907,31,'CAETANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110004,31,'CAETÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110103,31,'CAIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110202,31,'CAJURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110301,31,'CALDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110400,31,'CAMACHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110509,31,'CAMANDUCAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110608,31,'CAMBUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110707,31,'CAMBUQUIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110806,31,'CAMPANÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3110905,31,'CAMPANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111002,31,'CAMPESTRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111101,31,'CAMPINA VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111150,31,'CAMPO AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111200,31,'CAMPO BELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111309,31,'CAMPO DO MEIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111408,31,'CAMPO FLORIDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111507,31,'CAMPOS ALTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111606,31,'CAMPOS GERAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111705,31,'CANAÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111804,31,'CANÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3111903,31,'CANA VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112000,31,'CANDEIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112059,31,'CANTAGALO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112109,31,'CAPARAÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112208,31,'CAPELA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112307,31,'CAPELINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112406,31,'CAPETINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112505,31,'CAPIM BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112604,31,'CAPINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112653,31,'CAPITÃO ANDRADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112703,31,'CAPITÃO ENÉAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112802,31,'CAPITÓLIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3112901,31,'CAPUTIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113008,31,'CARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113107,31,'CARANAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113206,31,'CARANDAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113305,31,'CARANGOLA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113404,31,'CARATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113503,31,'CARBONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113602,31,'CAREAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113701,31,'CARLOS CHAGAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113800,31,'CARMÉSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3113909,31,'CARMO DA CACHOEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114006,31,'CARMO DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114105,31,'CARMO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114204,31,'CARMO DO CAJURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114303,31,'CARMO DO PARANAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114402,31,'CARMO DO RIO CLARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114501,31,'CARMÓPOLIS DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114550,31,'CARNEIRINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114600,31,'CARRANCAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114709,31,'CARVALHÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114808,31,'CARVALHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3114907,31,'CASA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115003,31,'CASCALHO RICO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115102,31,'CÁSSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115201,31,'CONCEIÇÃO DA BARRA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115300,31,'CATAGUASES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115359,31,'CATAS ALTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115409,31,'CATAS ALTAS DA NORUEGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115458,31,'CATUJI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115474,31,'CATUTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115508,31,'CAXAMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115607,31,'CEDRO DO ABAETÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115706,31,'CENTRAL DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115805,31,'CENTRALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3115904,31,'CHÁCARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116001,31,'CHALÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116100,31,'CHAPADA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116159,31,'CHAPADA GAÚCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116209,31,'CHIADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116308,31,'CIPOTÂNEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116407,31,'CLARAVAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116506,31,'CLARO DOS POÇÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116605,31,'CLÁUDIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116704,31,'COIMBRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116803,31,'COLUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3116902,31,'COMENDADOR GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117009,31,'COMERCINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117108,31,'CONCEIÇÃO DA APARECIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117207,31,'CONCEIÇÃO DAS PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117306,31,'CONCEIÇÃO DAS ALAGOAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117405,31,'CONCEIÇÃO DE IPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117504,31,'CONCEIÇÃO DO MATO DENTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117603,31,'CONCEIÇÃO DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117702,31,'CONCEIÇÃO DO RIO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117801,31,'CONCEIÇÃO DOS OUROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117836,31,'CÔNEGO MARINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117876,31,'CONFINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3117900,31,'CONGONHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118007,31,'CONGONHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118106,31,'CONGONHAS DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118205,31,'CONQUISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118304,31,'CONSELHEIRO LAFAIETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118403,31,'CONSELHEIRO PENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118502,31,'CONSOLAÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118601,31,'CONTAGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118700,31,'COQUEIRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118809,31,'CORAÇÃO DE JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3118908,31,'CORDISBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119005,31,'CORDISLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119104,31,'CORINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119203,31,'COROACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119302,31,'COROMANDEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119401,31,'CORONEL FABRICIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119500,31,'CORONEL MURTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119609,31,'CORONEL PACHECO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119708,31,'CORONEL XAVIER CHAVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119807,31,'CÓRREGO DANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119906,31,'CÓRREGO DO BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3119955,31,'CÓRREGO FUNDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120003,31,'CÓRREGO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120102,31,'COUTO DE MAGALHÃES DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120151,31,'CRISÓLITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120201,31,'CRISTAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120300,31,'CRISTÁLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120409,31,'CRISTIANO OTONI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120508,31,'CRISTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120607,31,'CRUCILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120706,31,'CRUZEIRO DA FORTALEZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120805,31,'CRUZÍLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120839,31,'CUPARAQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120870,31,'CURRAL DE DENTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3120904,31,'CURVELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121001,31,'DATAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121100,31,'DELFIM MOREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121209,31,'DELFINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121258,31,'DELTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121308,31,'DESCOBERTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121407,31,'DESTERRO DE ENTRE RIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121506,31,'DESTERRO DO MELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121605,31,'DIAMANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121704,31,'DIOGO DE VASCONCELOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121803,31,'DIONÍSIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3121902,31,'DIVINÉSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122009,31,'DIVINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122108,31,'DIVINO DAS LARANJEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122207,31,'DIVINOLÂNDIA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122306,31,'DIVINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122355,31,'DIVISA ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122405,31,'DIVISA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122454,31,'DIVISÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122470,31,'DOM BOSCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122504,31,'DOM CAVATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122603,31,'DOM JOAQUIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122702,31,'DOM SILVÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122801,31,'DOM VIÇOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3122900,31,'DONA EUSÉBIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123007,31,'DORES DE CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123106,31,'DORES DE GUANHÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123205,31,'DORES DO INDAIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123304,31,'DORES DO TURVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123403,31,'DORESÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123502,31,'DOURADOQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123528,31,'DURANDÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123601,31,'ELÓI MENDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123700,31,'ENGENHEIRO CALDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123809,31,'ENGENHEIRO NAVARRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123858,31,'ENTRE FOLHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3123908,31,'ENTRE RIOS DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124005,31,'ERVÁLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124104,31,'ESMERALDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124203,31,'ESPERA FELIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124302,31,'ESPINOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124401,31,'ESPÍRITO SANTO DO DOURADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124500,31,'ESTIVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124609,31,'ESTRELA DALVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124708,31,'ESTRELA DO INDAIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124807,31,'ESTRELA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3124906,31,'EUGENÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125002,31,'EWBANK DA CÂMARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125101,31,'EXTREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125200,31,'FAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125309,31,'FARIA LEMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125408,31,'FELÍCIO DOS SANTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125507,31,'SÃO GONÇALO DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125606,31,'FELISBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125705,31,'FELIXLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125804,31,'FERNANDES TOURINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125903,31,'FERROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3125952,31,'FERVEDOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126000,31,'FLORESTAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126109,31,'FORMIGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126208,31,'FORMOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126307,31,'FORTALEZA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126406,31,'FORTUNA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126505,31,'FRANCISCO BADARÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126604,31,'FRANCISCO DUMONT');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126703,31,'FRANCISCO SÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126752,31,'FRANCISCÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126802,31,'FREI GASPAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126901,31,'FREI INOCÊNCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3126950,31,'FREI LAGONEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127008,31,'FRONTEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127057,31,'FRONTEIRA DOS VALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127073,31,'FRUTA DE LEITE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127107,31,'FRUTAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127206,31,'FUNILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127305,31,'GALILÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127339,31,'GAMELEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127354,31,'GLAUCILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127370,31,'GOIABEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127388,31,'GOIANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127404,31,'GONÇALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127503,31,'GONZAGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127602,31,'GOUVEIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127701,31,'GOVERNADOR VALADARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127800,31,'GRÃO MOGOL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3127909,31,'GRUPIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128006,31,'GUANHÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128105,31,'GUAPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128204,31,'GUARACIABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128253,31,'GUARACIAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128303,31,'GUARANÉSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128402,31,'GUARANI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128501,31,'GUARARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128600,31,'GUARDA-MOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128709,31,'GUAXUPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128808,31,'GUIDOVAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3128907,31,'GUIMARÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129004,31,'GUIRICEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129103,31,'GURINHATÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129202,31,'HELIODORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129301,31,'IAPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129400,31,'IBERTIOGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129509,31,'IBIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129608,31,'IBIAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129657,31,'IBIRACATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129707,31,'IBIRACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129806,31,'IBIRITÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3129905,31,'IBITIÚRA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130002,31,'IBITURUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130051,31,'ICARAÍ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130101,31,'IGARAPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130200,31,'IGARATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130309,31,'IGUATAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130408,31,'IJACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130507,31,'ILICÍNEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130556,31,'IMBÉ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130606,31,'INCONFIDENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130655,31,'INDAIABIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130705,31,'INDIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130804,31,'INGAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3130903,31,'INHAPIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131000,31,'INHAÚMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131109,31,'INIMUTABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131158,31,'IPABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131208,31,'IPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131307,31,'IPATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131406,31,'IPIAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131505,31,'IPUIÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131604,31,'IRAÍ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131703,31,'ITABIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131802,31,'ITABIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3131901,31,'ITABIRITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132008,31,'ITACAMBIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132107,31,'ITACARAMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132206,31,'ITAGUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132305,31,'ITAIPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132404,31,'ITAJUBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132503,31,'ITAMARANDIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132602,31,'ITAMARATI DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132701,31,'ITAMBACURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132800,31,'ITAMBÉ DO MATO DENTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3132909,31,'ITAMOGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133006,31,'ITAMONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133105,31,'ITANHANDU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133204,31,'ITANHOMI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133303,31,'ITAOBIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133402,31,'ITAPAGIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133501,31,'ITAPECERICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133600,31,'ITAPEVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133709,31,'ITATIAIUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133758,31,'ITAÚ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133808,31,'ITAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3133907,31,'ITAVERAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134004,31,'ITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134103,31,'ITUETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134202,31,'ITUIUTABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134301,31,'ITUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134400,31,'ITURAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134509,31,'ITUTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134608,31,'JABOTICATUBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134707,31,'JACINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134806,31,'JACUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3134905,31,'JACUTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135001,31,'JAGUARAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135050,31,'JAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135076,31,'JAMPRUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135100,31,'JANAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135209,31,'JANUÁRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135308,31,'JAPARAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135357,31,'JAPONVAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135407,31,'JECEABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135456,31,'JENIPAPO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135506,31,'JEQUERI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135605,31,'JEQUITAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135704,31,'JEQUITIBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135803,31,'JEQUITINHONHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3135902,31,'JESUÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136009,31,'JOAÍMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136108,31,'JOANÉSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136207,31,'JOÃO MONLEVADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136306,31,'JOÃO PINHEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136405,31,'JOAQUIM FELÍCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136504,31,'JORDÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136520,31,'JOSÉ GONÇALVES DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136553,31,'JOSÉ RAYDAN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136579,31,'JOSENÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136603,31,'NOVA UNIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136652,31,'JUATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136702,31,'JUIZ DE FORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136801,31,'JURAMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136900,31,'JURUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3136959,31,'JUVENÍLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137007,31,'LADAINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137106,31,'LAGAMAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137205,31,'LAGOA DA PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137304,31,'LAGOA DOS PATOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137403,31,'LAGOA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137502,31,'LAGOA FORMOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137536,31,'LAGOA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137601,31,'LAGOA SANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137700,31,'LAJINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137809,31,'LAMBARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3137908,31,'LAMIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138005,31,'LARANJAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138104,31,'LASSANCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138203,31,'LAVRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138302,31,'LEANDRO FERREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138351,31,'LEME DO PRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138401,31,'LEOPOLDINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138500,31,'LIBERDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138609,31,'LIMA DUARTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138625,31,'LIMEIRA DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138658,31,'LONTRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138674,31,'LUISBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138682,31,'LUISLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138708,31,'LUMINÁRIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138807,31,'LUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3138906,31,'MACHACALIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139003,31,'MACHADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139102,31,'MADRE DE DEUS DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139201,31,'MALACACHETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139250,31,'MAMONAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139300,31,'MANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139409,31,'MANHUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139508,31,'MANHUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139607,31,'MANTENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139706,31,'MARAVILHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139805,31,'MAR DE ESPANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3139904,31,'MARIA DA FÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140001,31,'MARIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140100,31,'MARILAC');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140159,31,'MÁRIO CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140209,31,'MARIPÁ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140308,31,'MARLIÉRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140407,31,'MARMELÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140506,31,'MARTINHO CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140530,31,'MARTINS SOARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140555,31,'MATA VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140605,31,'MATERLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140704,31,'MATEUS LEME');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140803,31,'MATIAS BARBOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140852,31,'MATIAS CARDOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3140902,31,'MATIPÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141009,31,'MATO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141108,31,'MATOZINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141207,31,'MATUTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141306,31,'MEDEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141405,31,'MEDINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141504,31,'MENDES PIMENTEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141603,31,'MERCÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141702,31,'MESQUITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141801,31,'MINAS NOVAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3141900,31,'MINDURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142007,31,'MIRABELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142106,31,'MIRADOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142205,31,'MIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142254,31,'MIRAVÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142304,31,'MOEDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142403,31,'MOEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142502,31,'MONJOLOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142601,31,'MONSENHOR PAULO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142700,31,'MONTALVÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142809,31,'MONTE ALEGRE DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3142908,31,'MONTE AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143005,31,'MONTE BELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143104,31,'MONTE CARMELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143153,31,'MONTE FORMOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143203,31,'MONTE SANTO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143302,31,'MONTES CLAROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143401,31,'MONTE SIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143450,31,'MONTEZUMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143500,31,'MORADA NOVA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143609,31,'MORRO DA GARÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143708,31,'MORRO DO PILAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143807,31,'MUNHOZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3143906,31,'MURIAÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144003,31,'MUTUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144102,31,'MUZAMBINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144201,31,'NACIP RAYDAN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144300,31,'NANUQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144359,31,'NAQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144375,31,'NATALÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144409,31,'NATÉRCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144508,31,'NAZARENO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144607,31,'NEPOMUCENO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144656,31,'NINHEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144672,31,'NOVA BELÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144706,31,'NOVA ERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144805,31,'NOVA LIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3144904,31,'NOVA MÓDICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145000,31,'NOVA PONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145059,31,'NOVA PORTEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145109,31,'NOVA RESENDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145208,31,'NOVA SERRANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145307,31,'NOVO CRUZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145356,31,'NOVO ORIENTE DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145372,31,'NOVORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145406,31,'OLARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145455,31,'OLHOS-D''ÁGUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145505,31,'OLÍMPIO NORONHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145604,31,'OLIVEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145703,31,'OLIVEIRA FORTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145802,31,'ONÇA DE PITANGUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145851,31,'ORATÓRIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145877,31,'ORIZÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3145901,31,'OURO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146008,31,'OURO FINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146107,31,'OURO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146206,31,'OURO VERDE DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146255,31,'PADRE CARVALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146305,31,'PADRE PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146404,31,'PAINEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146503,31,'PAINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146552,31,'PAI PEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146602,31,'PAIVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146701,31,'PALMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146750,31,'PALMÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3146909,31,'PAPAGAIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147006,31,'PARACATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147105,31,'PARÁ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147204,31,'PARAGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147303,31,'PARAISÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147402,31,'PARAOPEBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147501,31,'PASSABÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147600,31,'PASSA QUATRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147709,31,'PASSA TEMPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147808,31,'PASSA-VINTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147907,31,'PASSOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3147956,31,'PATIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148004,31,'PATOS DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148103,31,'PATROCÍNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148202,31,'PATROCÍNIO DO MURIAÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148301,31,'PAULA CÂNDIDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148400,31,'PAULISTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148509,31,'PAVÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148608,31,'PEÇANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148707,31,'PEDRA AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148756,31,'PEDRA BONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148806,31,'PEDRA DO ANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3148905,31,'PEDRA DO INDAIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149002,31,'PEDRA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149101,31,'PEDRALVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149150,31,'PEDRAS DE MARIA DA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149200,31,'PEDRINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149309,31,'PEDRO LEOPOLDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149408,31,'PEDRO TEIXEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149507,31,'PEQUERI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149606,31,'PEQUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149705,31,'PERDIGÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149804,31,'PERDIZES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149903,31,'PERDÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3149952,31,'PERIQUITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150000,31,'PESCADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150109,31,'PIAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150158,31,'PIEDADE DE CARATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150208,31,'PIEDADE DE PONTE NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150307,31,'PIEDADE DO RIO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150406,31,'PIEDADE DOS GERAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150505,31,'PIMENTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150539,31,'PINGO-D''ÁGUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150570,31,'PINTÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150604,31,'PIRACEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150703,31,'PIRAJUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150802,31,'PIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3150901,31,'PIRANGUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151008,31,'PIRANGUINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151107,31,'PIRAPETINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151206,31,'PIRAPORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151305,31,'PIRAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151404,31,'PITANGUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151503,31,'PIUMHI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151602,31,'PLANURA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151701,31,'POÇO FUNDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151800,31,'POÇOS DE CALDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3151909,31,'POCRANE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152006,31,'POMPÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152105,31,'PONTE NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152131,31,'PONTO CHIQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152170,31,'PONTO DOS VOLANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152204,31,'PORTEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152303,31,'PORTO FIRME');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152402,31,'POTÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152501,31,'POUSO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152600,31,'POUSO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152709,31,'PRADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152808,31,'PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3152907,31,'PRATÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153004,31,'PRATINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153103,31,'PRESIDENTE BERNARDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153202,31,'PRESIDENTE JUSCELINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153301,31,'PRESIDENTE KUBITSCHEK');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153400,31,'PRESIDENTE OLEGÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153509,31,'ALTO JEQUITIBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153608,31,'PRUDENTE DE MORAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153707,31,'QUARTEL GERAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153806,31,'QUELUZITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3153905,31,'RAPOSOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154002,31,'RAUL SOARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154101,31,'RECREIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154150,31,'REDUTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154200,31,'RESENDE COSTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154309,31,'RESPLENDOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154408,31,'RESSAQUINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154457,31,'RIACHINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154507,31,'RIACHO DOS MACHADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154606,31,'RIBEIRÃO DAS NEVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154705,31,'RIBEIRÃO VERMELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154804,31,'RIO ACIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3154903,31,'RIO CASCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155009,31,'RIO DOCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155108,31,'RIO DO PRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155207,31,'RIO ESPERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155306,31,'RIO MANSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155405,31,'RIO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155504,31,'RIO PARANAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155603,31,'RIO PARDO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155702,31,'RIO PIRACICABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155801,31,'RIO POMBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3155900,31,'RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156007,31,'RIO VERMELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156106,31,'RITÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156205,31,'ROCHEDO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156304,31,'RODEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156403,31,'ROMARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156452,31,'ROSÁRIO DA LIMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156502,31,'RUBELITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156601,31,'RUBIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156700,31,'SABARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156809,31,'SABINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3156908,31,'SACRAMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157005,31,'SALINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157104,31,'SALTO DA DIVISA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157203,31,'SANTA BÁRBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157252,31,'SANTA BÁRBARA DO LESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157278,31,'SANTA BÁRBARA DO MONTE VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157302,31,'SANTA BÁRBARA DO TUGÚRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157336,31,'SANTA CRUZ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157377,31,'SANTA CRUZ DE SALINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157401,31,'SANTA CRUZ DO ESCALVADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157500,31,'SANTA EFIGÊNIA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157609,31,'SANTA FÉ DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157658,31,'SANTA HELENA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157708,31,'SANTA JULIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157807,31,'SANTA LUZIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3157906,31,'SANTA MARGARIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158003,31,'SANTA MARIA DE ITABIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158102,31,'SANTA MARIA DO SALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158201,31,'SANTA MARIA DO SUAÇUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158300,31,'SANTANA DA VARGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158409,31,'SANTANA DE CATAGUASES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158508,31,'SANTANA DE PIRAPAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158607,31,'SANTANA DO DESERTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158706,31,'SANTANA DO GARAMBÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158805,31,'SANTANA DO JACARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158904,31,'SANTANA DO MANHUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3158953,31,'SANTANA DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159001,31,'SANTANA DO RIACHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159100,31,'SANTANA DOS MONTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159209,31,'SANTA RITA DE CALDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159308,31,'SANTA RITA DE JACUTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159357,31,'SANTA RITA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159407,31,'SANTA RITA DE IBITIPOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159506,31,'SANTA RITA DO ITUETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159605,31,'SANTA RITA DO SAPUCAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159704,31,'SANTA ROSA DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159803,31,'SANTA VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3159902,31,'SANTO ANTÔNIO DO AMPARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160009,31,'SANTO ANTÔNIO DO AVENTUREIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160108,31,'SANTO ANTÔNIO DO GRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160207,31,'SANTO ANTÔNIO DO ITAMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160306,31,'SANTO ANTÔNIO DO JACINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160405,31,'SANTO ANTÔNIO DO MONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160454,31,'SANTO ANTÔNIO DO RETIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160504,31,'SANTO ANTÔNIO DO RIO ABAIXO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160603,31,'SANTO HIPÓLITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160702,31,'SANTOS DUMONT');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160801,31,'SÃO BENTO ABADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160900,31,'SÃO BRÁS DO SUAÇUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3160959,31,'SÃO DOMINGOS DAS DORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161007,31,'SÃO DOMINGOS DO PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161056,31,'SÃO FÉLIX DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161106,31,'SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161205,31,'SÃO FRANCISCO DE PAULA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161304,31,'SÃO FRANCISCO DE SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161403,31,'SÃO FRANCISCO DO GLÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161502,31,'SÃO GERALDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161601,31,'SÃO GERALDO DA PIEDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161650,31,'SÃO GERALDO DO BAIXIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161700,31,'SÃO GONÇALO DO ABAETÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161809,31,'SÃO GONÇALO DO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3161908,31,'SÃO GONÇALO DO RIO ABAIXO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162005,31,'SÃO GONÇALO DO SAPUCAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162104,31,'SÃO GOTARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162203,31,'SÃO JOÃO BATISTA DO GLÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162252,31,'SÃO JOÃO DA LAGOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162302,31,'SÃO JOÃO DA MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162401,31,'SÃO JOÃO DA PONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162450,31,'SÃO JOÃO DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162500,31,'SÃO JOÃO DEL REI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162559,31,'SÃO JOÃO DO MANHUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162575,31,'SÃO JOÃO DO MANTENINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162609,31,'SÃO JOÃO DO ORIENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162658,31,'SÃO JOÃO DO PACUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162708,31,'SÃO JOÃO DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162807,31,'SÃO JOÃO EVANGELISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162906,31,'SÃO JOÃO NEPOMUCENO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162922,31,'SÃO JOAQUIM DE BICAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162948,31,'SÃO JOSÉ DA BARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3162955,31,'SÃO JOSÉ DA LAPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163003,31,'SÃO JOSÉ DA SAFIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163102,31,'SÃO JOSÉ DA VARGINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163201,31,'SÃO JOSÉ DO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163300,31,'SÃO JOSÉ DO DIVINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163409,31,'SÃO JOSÉ DO GOIABAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163508,31,'SÃO JOSÉ DO JACURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163607,31,'SÃO JOSÉ DO MANTIMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163706,31,'SÃO LOURENÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163805,31,'SÃO MIGUEL DO ANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3163904,31,'SÃO PEDRO DA UNIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164001,31,'SÃO PEDRO DOS FERROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164100,31,'SÃO PEDRO DO SUAÇUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164209,31,'SÃO ROMÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164308,31,'SÃO ROQUE DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164407,31,'SÃO SEBASTIÃO DA BELA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164431,31,'SÃO SEBASTIÃO DA VARGEM ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164472,31,'SÃO SEBASTIÃO DO ANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164506,31,'SÃO SEBASTIÃO DO MARANHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164605,31,'SÃO SEBASTIÃO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164704,31,'SÃO SEBASTIÃO DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164803,31,'SÃO SEBASTIÃO DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3164902,31,'SÃO SEBASTIÃO DO RIO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165008,31,'SÃO TIAGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165107,31,'SÃO TOMÁS DE AQUINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165206,31,'SÃO THOMÉ DAS LETRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165305,31,'SÃO VICENTE DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165404,31,'SAPUCAÍ-MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165503,31,'SARDOÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165537,31,'SARZEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165552,31,'SETUBINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165560,31,'SEM-PEIXE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165578,31,'SENADOR AMARAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165602,31,'SENADOR CORTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165701,31,'SENADOR FIRMINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165800,31,'SENADOR JOSÉ BENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3165909,31,'SENADOR MODESTINO GONÇALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166006,31,'SENHORA DE OLIVEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166105,31,'SENHORA DO PORTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166204,31,'SENHORA DOS REMÉDIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166303,31,'SERICITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166402,31,'SERITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166501,31,'SERRA AZUL DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166600,31,'SERRA DA SAUDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166709,31,'SERRA DOS AIMORÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166808,31,'SERRA DO SALITRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166907,31,'SERRANIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3166956,31,'SERRANÓPOLIS DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167004,31,'SERRANOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167103,31,'SERRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167202,31,'SETE LAGOAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167301,31,'SILVEIRÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167400,31,'SILVIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167509,31,'SIMÃO PEREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167608,31,'SIMONÉSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167707,31,'SOBRÁLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167806,31,'SOLEDADE DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3167905,31,'TABULEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168002,31,'TAIOBEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168051,31,'TAPARUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168101,31,'TAPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168200,31,'TAPIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168309,31,'TAQUARAÇU DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168408,31,'TARUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168507,31,'TEIXEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168606,31,'TEÓFILO OTONI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168705,31,'TIMÓTEO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168804,31,'TIRADENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3168903,31,'TIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169000,31,'TOCANTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169059,31,'TOCOS DO MOJI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169109,31,'TOLEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169208,31,'TOMBOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169307,31,'TRÊS CORAÇÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169356,31,'TRÊS MARIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169406,31,'TRÊS PONTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169505,31,'TUMIRITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169604,31,'TUPACIGUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169703,31,'TURMALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169802,31,'TURVOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3169901,31,'UBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170008,31,'UBAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170057,31,'UBAPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170107,31,'UBERABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170206,31,'UBERLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170305,31,'UMBURATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170404,31,'UNAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170438,31,'UNIÃO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170479,31,'URUANA DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170503,31,'URUCÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170529,31,'URUCUIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170578,31,'VARGEM ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170602,31,'VARGEM BONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170651,31,'VARGEM GRANDE DO RIO PARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170701,31,'VARGINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170750,31,'VARJÃO DE MINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170800,31,'VÁRZEA DA PALMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3170909,31,'VARZELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171006,31,'VAZANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171030,31,'VERDELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171071,31,'VEREDINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171105,31,'VERÍSSIMO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171154,31,'VERMELHO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171204,31,'VESPASIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171303,31,'VIÇOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171402,31,'VIEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171501,31,'MATHIAS LOBATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171600,31,'VIRGEM DA LAPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171709,31,'VIRGÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171808,31,'VIRGINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3171907,31,'VIRGOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3172004,31,'VISCONDE DO RIO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3172103,31,'VOLTA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3172202,31,'WENCESLAU BRAZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200102,32,'AFONSO CLÁUDIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200136,32,'ÁGUIA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200169,32,'ÁGUA DOCE DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200201,32,'ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200300,32,'ALFREDO CHAVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200359,32,'ALTO RIO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200409,32,'ANCHIETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200508,32,'APIACÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200607,32,'ARACRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200706,32,'ATILIO VIVACQUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200805,32,'BAIXO GUANDU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3200904,32,'BARRA DE SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201001,32,'BOA ESPERANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201100,32,'BOM JESUS DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201159,32,'BREJETUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201209,32,'CACHOEIRO DE ITAPEMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201308,32,'CARIACICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201407,32,'CASTELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201506,32,'COLATINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201605,32,'CONCEIÇÃO DA BARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201704,32,'CONCEIÇÃO DO CASTELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201803,32,'DIVINO DE SÃO LOURENÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3201902,32,'DOMINGOS MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202009,32,'DORES DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202108,32,'ECOPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202207,32,'FUNDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202256,32,'GOVERNADOR LINDENBERG');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202306,32,'GUAÇUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202405,32,'GUARAPARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202454,32,'IBATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202504,32,'IBIRAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202553,32,'IBITIRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202603,32,'ICONHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202652,32,'IRUPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202702,32,'ITAGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202801,32,'ITAPEMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3202900,32,'ITARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203007,32,'IÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203056,32,'JAGUARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203106,32,'JERÔNIMO MONTEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203130,32,'JOÃO NEIVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203163,32,'LARANJA DA TERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203205,32,'LINHARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203304,32,'MANTENÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203320,32,'MARATAÍZES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203346,32,'MARECHAL FLORIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203353,32,'MARILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203403,32,'MIMOSO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203502,32,'MONTANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203601,32,'MUCURICI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203700,32,'MUNIZ FREIRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203809,32,'MUQUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3203908,32,'NOVA VENÉCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204005,32,'PANCAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204054,32,'PEDRO CANÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204104,32,'PINHEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204203,32,'PIÚMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204252,32,'PONTO BELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204302,32,'PRESIDENTE KENNEDY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204351,32,'RIO BANANAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204401,32,'RIO NOVO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204500,32,'SANTA LEOPOLDINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204559,32,'SANTA MARIA DE JETIBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204609,32,'SANTA TERESA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204658,32,'SÃO DOMINGOS DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204708,32,'SÃO GABRIEL DA PALHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204807,32,'SÃO JOSÉ DO CALÇADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204906,32,'SÃO MATEUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3204955,32,'SÃO ROQUE DO CANAÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205002,32,'SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205010,32,'SOORETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205036,32,'VARGEM ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205069,32,'VENDA NOVA DO IMIGRANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205101,32,'VIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205150,32,'VILA PAVÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205176,32,'VILA VALÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205200,32,'VILA VELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3205309,32,'VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300100,33,'ANGRA DOS REIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300159,33,'APERIBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300209,33,'ARARUAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300225,33,'AREAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300233,33,'ARMAÇÃO DOS BÚZIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300258,33,'ARRAIAL DO CABO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300308,33,'BARRA DO PIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300407,33,'BARRA MANSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300456,33,'BELFORD ROXO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300506,33,'BOM JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300605,33,'BOM JESUS DO ITABAPOANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300704,33,'CABO FRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300803,33,'CACHOEIRAS DE MACACU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300902,33,'CAMBUCI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300936,33,'CARAPEBUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3300951,33,'COMENDADOR LEVY GASPARIAN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301009,33,'CAMPOS DOS GOYTACAZES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301108,33,'CANTAGALO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301157,33,'CARDOSO MOREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301207,33,'CARMO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301306,33,'CASIMIRO DE ABREU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301405,33,'CONCEIÇÃO DE MACABU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301504,33,'CORDEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301603,33,'DUAS BARRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301702,33,'DUQUE DE CAXIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301801,33,'ENGENHEIRO PAULO DE FRONTIN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301850,33,'GUAPIMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301876,33,'IGUABA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3301900,33,'ITABORAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302007,33,'ITAGUAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302056,33,'ITALVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302106,33,'ITAOCARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302205,33,'ITAPERUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302254,33,'ITATIAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302270,33,'JAPERI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302304,33,'LAJE DO MURIAÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302403,33,'MACAÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302452,33,'MACUCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302502,33,'MAGÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302601,33,'MANGARATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302700,33,'MARICÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302809,33,'MENDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302858,33,'MESQUITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3302908,33,'MIGUEL PEREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303005,33,'MIRACEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303104,33,'NATIVIDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303203,33,'NILÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303302,33,'NITERÓI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303401,33,'NOVA FRIBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303500,33,'NOVA IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303609,33,'PARACAMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303708,33,'PARAÍBA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303807,33,'PARATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303856,33,'PATY DO ALFERES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303906,33,'PETRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3303955,33,'PINHEIRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304003,33,'PIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304102,33,'PORCIÚNCULA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304110,33,'PORTO REAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304128,33,'QUATIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304144,33,'QUEIMADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304151,33,'QUISSAMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304201,33,'RESENDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304300,33,'RIO BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304409,33,'RIO CLARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304508,33,'RIO DAS FLORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304524,33,'RIO DAS OSTRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304557,33,'RIO DE JANEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304607,33,'SANTA MARIA MADALENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304706,33,'SANTO ANTÔNIO DE PÁDUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304755,33,'SÃO FRANCISCO DE ITABAPOANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304805,33,'SÃO FIDÉLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3304904,33,'SÃO GONÇALO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305000,33,'SÃO JOÃO DA BARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305109,33,'SÃO JOÃO DE MERITI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305133,33,'SÃO JOSÉ DE UBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305158,33,'SÃO JOSÉ DO VALE DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305208,33,'SÃO PEDRO DA ALDEIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305307,33,'SÃO SEBASTIÃO DO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305406,33,'SAPUCAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305505,33,'SAQUAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305554,33,'SEROPÉDICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305604,33,'SILVA JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305703,33,'SUMIDOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305752,33,'TANGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305802,33,'TERESÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3305901,33,'TRAJANO DE MORAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3306008,33,'TRÊS RIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3306107,33,'VALENÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3306156,33,'VARRE-SAI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3306206,33,'VASSOURAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3306305,33,'VOLTA REDONDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500105,35,'ADAMANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500204,35,'ADOLFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500303,35,'AGUAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500402,35,'ÁGUAS DA PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500501,35,'ÁGUAS DE LINDÓIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500550,35,'ÁGUAS DE SANTA BÁRBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500600,35,'ÁGUAS DE SÃO PEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500709,35,'AGUDOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500758,35,'ALAMBARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500808,35,'ALFREDO MARCONDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3500907,35,'ALTAIR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501004,35,'ALTINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501103,35,'ALTO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501152,35,'ALUMÍNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501202,35,'ÁLVARES FLORENCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501301,35,'ÁLVARES MACHADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501400,35,'ÁLVARO DE CARVALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501509,35,'ALVINLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501608,35,'AMERICANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501707,35,'AMÉRICO BRASILIENSE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501806,35,'AMÉRICO DE CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3501905,35,'AMPARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502002,35,'ANALÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502101,35,'ANDRADINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502200,35,'ANGATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502309,35,'ANHEMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502408,35,'ANHUMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502507,35,'APARECIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502606,35,'APARECIDA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502705,35,'APIAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502754,35,'ARAÇARIGUAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502804,35,'ARAÇATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3502903,35,'ARAÇOIABA DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503000,35,'ARAMINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503109,35,'ARANDU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503158,35,'ARAPEÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503208,35,'ARARAQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503307,35,'ARARAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503356,35,'ARCO-ÍRIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503406,35,'AREALVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503505,35,'AREIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503604,35,'AREIÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503703,35,'ARIRANHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503802,35,'ARTUR NOGUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503901,35,'ARUJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3503950,35,'ASPÁSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504008,35,'ASSIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504107,35,'ATIBAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504206,35,'AURIFLAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504305,35,'AVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504404,35,'AVANHANDAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504503,35,'AVARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504602,35,'BADY BASSITT');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504701,35,'BALBINOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504800,35,'BÁLSAMO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3504909,35,'BANANAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505005,35,'BARÃO DE ANTONINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505104,35,'BARBOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505203,35,'BARIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505302,35,'BARRA BONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505351,35,'BARRA DO CHAPÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505401,35,'BARRA DO TURVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505500,35,'BARRETOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505609,35,'BARRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505708,35,'BARUERI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505807,35,'BASTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3505906,35,'BATATAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506003,35,'BAURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506102,35,'BEBEDOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506201,35,'BENTO DE ABREU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506300,35,'BERNARDINO DE CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506359,35,'BERTIOGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506409,35,'BILAC');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506508,35,'BIRIGUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506607,35,'BIRITIBA-MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506706,35,'BOA ESPERANÇA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506805,35,'BOCAINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3506904,35,'BOFETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507001,35,'BOITUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507100,35,'BOM JESUS DOS PERDÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507159,35,'BOM SUCESSO DE ITARARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507209,35,'BORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507308,35,'BORACÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507407,35,'BORBOREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507456,35,'BOREBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507506,35,'BOTUCATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507605,35,'BRAGANÇA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507704,35,'BRAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507753,35,'BREJO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507803,35,'BRODOWSKI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3507902,35,'BROTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508009,35,'BURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508108,35,'BURITAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508207,35,'BURITIZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508306,35,'CABRÁLIA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508405,35,'CABREÚVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508504,35,'CAÇAPAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508603,35,'CACHOEIRA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508702,35,'CACONDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508801,35,'CAFELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3508900,35,'CAIABU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509007,35,'CAIEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509106,35,'CAIUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509205,35,'CAJAMAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509254,35,'CAJATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509304,35,'CAJOBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509403,35,'CAJURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509452,35,'CAMPINA DO MONTE ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509502,35,'CAMPINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509601,35,'CAMPO LIMPO PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509700,35,'CAMPOS DO JORDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509809,35,'CAMPOS NOVOS PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509908,35,'CANANÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3509957,35,'CANAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510005,35,'CÂNDIDO MOTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510104,35,'CÂNDIDO RODRIGUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510153,35,'CANITAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510203,35,'CAPÃO BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510302,35,'CAPELA DO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510401,35,'CAPIVARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510500,35,'CARAGUATATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510609,35,'CARAPICUÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510708,35,'CARDOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510807,35,'CASA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3510906,35,'CÁSSIA DOS COQUEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511003,35,'CASTILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511102,35,'CATANDUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511201,35,'CATIGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511300,35,'CEDRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511409,35,'CERQUEIRA CÉSAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511508,35,'CERQUILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511607,35,'CESÁRIO LANGE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511706,35,'CHARQUEADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3511904,35,'CLEMENTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512001,35,'COLINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512100,35,'COLÔMBIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512209,35,'CONCHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512308,35,'CONCHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512407,35,'CORDEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512506,35,'COROADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512605,35,'CORONEL MACEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512704,35,'CORUMBATAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512803,35,'COSMÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3512902,35,'COSMORAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513009,35,'COTIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513108,35,'CRAVINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513207,35,'CRISTAIS PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513306,35,'CRUZÁLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513405,35,'CRUZEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513504,35,'CUBATÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513603,35,'CUNHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513702,35,'DESCALVADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513801,35,'DIADEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513850,35,'DIRCE REIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3513900,35,'DIVINOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514007,35,'DOBRADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514106,35,'DOIS CÓRREGOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514205,35,'DOLCINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514304,35,'DOURADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514403,35,'DRACENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514502,35,'DUARTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514601,35,'DUMONT');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514700,35,'ECHAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514809,35,'ELDORADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514908,35,'ELIAS FAUSTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514924,35,'ELISIÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3514957,35,'EMBAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515004,35,'EMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515103,35,'EMBU-GUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515129,35,'EMILIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515152,35,'ENGENHEIRO COELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515186,35,'ESPÍRITO SANTO DO PINHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515194,35,'ESPÍRITO SANTO DO TURVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515202,35,'ESTRELA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515301,35,'ESTRELA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515350,35,'EUCLIDES DA CUNHA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515400,35,'FARTURA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515509,35,'FERNANDÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515608,35,'FERNANDO PRESTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515657,35,'FERNÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515707,35,'FERRAZ DE VASCONCELOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515806,35,'FLORA RICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3515905,35,'FLOREAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516002,35,'FLÓRIDA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516101,35,'FLORÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516200,35,'FRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516309,35,'FRANCISCO MORATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516408,35,'FRANCO DA ROCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516507,35,'GABRIEL MONTEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516606,35,'GÁLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516705,35,'GARÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516804,35,'GASTÃO VIDIGAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516853,35,'GAVIÃO PEIXOTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3516903,35,'GENERAL SALGADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517000,35,'GETULINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517109,35,'GLICÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517208,35,'GUAIÇARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517307,35,'GUAIMBÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517406,35,'GUAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517505,35,'GUAPIAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517604,35,'GUAPIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517703,35,'GUARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517802,35,'GUARAÇAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3517901,35,'GUARACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518008,35,'GUARANI D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518107,35,'GUARANTÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518206,35,'GUARARAPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518305,35,'GUARAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518404,35,'GUARATINGUETÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518503,35,'GUAREÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518602,35,'GUARIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518701,35,'GUARUJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518800,35,'GUARULHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518859,35,'GUATAPARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3518909,35,'GUZOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519006,35,'HERCULÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519055,35,'HOLAMBRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519071,35,'HORTOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519105,35,'IACANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519204,35,'IACRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519253,35,'IARAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519303,35,'IBATÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519402,35,'IBIRÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519501,35,'IBIRAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519600,35,'IBITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519709,35,'IBIÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519808,35,'ICÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3519907,35,'IEPÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520004,35,'IGARAÇU DO TIETÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520103,35,'IGARAPAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520202,35,'IGARATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520301,35,'IGUAPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520400,35,'ILHABELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520426,35,'ILHA COMPRIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520442,35,'ILHA SOLTEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520509,35,'INDAIATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520608,35,'INDIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520707,35,'INDIAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520806,35,'INÚBIA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3520905,35,'IPAUSSU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521002,35,'IPERÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521101,35,'IPEÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521150,35,'IPIGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521200,35,'IPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521309,35,'IPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521408,35,'IRACEMÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521507,35,'IRAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521606,35,'IRAPURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521705,35,'ITABERÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521804,35,'ITAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3521903,35,'ITAJOBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522000,35,'ITAJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522109,35,'ITANHAÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522158,35,'ITAÓCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522208,35,'ITAPECERICA DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522307,35,'ITAPETININGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522406,35,'ITAPEVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522505,35,'ITAPEVI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522604,35,'ITAPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522653,35,'ITAPIRAPUÃ PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522703,35,'ITÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522802,35,'ITAPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3522901,35,'ITAPUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523008,35,'ITAPURA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523107,35,'ITAQUAQUECETUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523206,35,'ITARARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523305,35,'ITARIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523404,35,'ITATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523503,35,'ITATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523602,35,'ITIRAPINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523701,35,'ITIRAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523800,35,'ITOBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3523909,35,'ITU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524006,35,'ITUPEVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524105,35,'ITUVERAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524204,35,'JABORANDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524303,35,'JABOTICABAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524402,35,'JACAREÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524501,35,'JACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524600,35,'JACUPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524709,35,'JAGUARIÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524808,35,'JALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3524907,35,'JAMBEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525003,35,'JANDIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525102,35,'JARDINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525201,35,'JARINU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525300,35,'JAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525409,35,'JERIQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525508,35,'JOANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525607,35,'JOÃO RAMALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525706,35,'JOSÉ BONIFÁCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525805,35,'JÚLIO MESQUITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525854,35,'JUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3525904,35,'JUNDIAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526001,35,'JUNQUEIRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526100,35,'JUQUIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526209,35,'JUQUITIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526308,35,'LAGOINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526407,35,'LARANJAL PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526506,35,'LAVÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526605,35,'LAVRINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526704,35,'LEME');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526803,35,'LENÇÓIS PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3526902,35,'LIMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527009,35,'LINDÓIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527108,35,'LINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527207,35,'LORENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527256,35,'LOURDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527306,35,'LOUVEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527405,35,'LUCÉLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527504,35,'LUCIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527603,35,'LUÍS ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527702,35,'LUIZIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527801,35,'LUPÉRCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3527900,35,'LUTÉCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528007,35,'MACATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528106,35,'MACAUBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528205,35,'MACEDÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528304,35,'MAGDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528403,35,'MAIRINQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528502,35,'MAIRIPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528601,35,'MANDURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528700,35,'MARABÁ PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528809,35,'MARACAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528858,35,'MARAPOAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3528908,35,'MARIÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529005,35,'MARÍLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529104,35,'MARINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529203,35,'MARTINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529302,35,'MATÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529401,35,'MAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529500,35,'MENDONÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529609,35,'MERIDIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529658,35,'MESÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529708,35,'MIGUELÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529807,35,'MINEIROS DO TIETÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3529906,35,'MIRACATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530003,35,'MIRA ESTRELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530102,35,'MIRANDÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530201,35,'MIRANTE DO PARANAPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530300,35,'MIRASSOL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530409,35,'MIRASSOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530508,35,'MOCOCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530607,35,'MOGI DAS CRUZES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530706,35,'MOGI GUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530805,35,'MOJI MIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3530904,35,'MOMBUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531001,35,'MONÇÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531100,35,'MONGAGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531209,35,'MONTE ALEGRE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531308,35,'MONTE ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531407,35,'MONTE APRAZÍVEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531506,35,'MONTE AZUL PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531605,35,'MONTE CASTELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531704,35,'MONTEIRO LOBATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531803,35,'MONTE MOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3531902,35,'MORRO AGUDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532009,35,'MORUNGABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532058,35,'MOTUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532108,35,'MURUTINGA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532157,35,'NANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532207,35,'NARANDIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532306,35,'NATIVIDADE DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532405,35,'NAZARÉ PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532504,35,'NEVES PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532603,35,'NHANDEARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532702,35,'NIPOÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532801,35,'NOVA ALIANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532827,35,'NOVA CAMPINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532843,35,'NOVA CANAÃ PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532868,35,'NOVA CASTILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3532900,35,'NOVA EUROPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533007,35,'NOVA GRANADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533106,35,'NOVA GUATAPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533205,35,'NOVA INDEPENDÊNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533254,35,'NOVAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533304,35,'NOVA LUZITÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533403,35,'NOVA ODESSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533502,35,'NOVO HORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533601,35,'NUPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533700,35,'OCAUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533809,35,'ÓLEO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3533908,35,'OLÍMPIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534005,35,'ONDA VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534104,35,'ORIENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534203,35,'ORINDIÚVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534302,35,'ORLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534401,35,'OSASCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534500,35,'OSCAR BRESSANE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534609,35,'OSVALDO CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534708,35,'OURINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534757,35,'OUROESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534807,35,'OURO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3534906,35,'PACAEMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535002,35,'PALESTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535101,35,'PALMARES PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535200,35,'PALMEIRA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535309,35,'PALMITAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535408,35,'PANORAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535507,35,'PARAGUAÇU PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535606,35,'PARAIBUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535705,35,'PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535804,35,'PARANAPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3535903,35,'PARANAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536000,35,'PARAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536109,35,'PARDINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536208,35,'PARIQUERA-AÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536257,35,'PARISI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536307,35,'PATROCÍNIO PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536406,35,'PAULICÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536505,35,'PAULÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536570,35,'PAULISTÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536604,35,'PAULO DE FARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536703,35,'PEDERNEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536802,35,'PEDRA BELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3536901,35,'PEDRANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537008,35,'PEDREGULHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537107,35,'PEDREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537156,35,'PEDRINHAS PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537206,35,'PEDRO DE TOLEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537305,35,'PENÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537404,35,'PEREIRA BARRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537503,35,'PEREIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537602,35,'PERUÍBE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537701,35,'PIACATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537800,35,'PIEDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3537909,35,'PILAR DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538006,35,'PINDAMONHANGABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538105,35,'PINDORAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538204,35,'PINHALZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538303,35,'PIQUEROBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538501,35,'PIQUETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538600,35,'PIRACAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538709,35,'PIRACICABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538808,35,'PIRAJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3538907,35,'PIRAJUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539004,35,'PIRANGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539103,35,'PIRAPORA DO BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539202,35,'PIRAPOZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539301,35,'PIRASSUNUNGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539400,35,'PIRATININGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539509,35,'PITANGUEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539608,35,'PLANALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539707,35,'PLATINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539806,35,'POÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3539905,35,'POLONI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540002,35,'POMPÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540101,35,'PONGAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540200,35,'PONTAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540259,35,'PONTALINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540309,35,'PONTES GESTAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540408,35,'POPULINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540507,35,'PORANGABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540606,35,'PORTO FELIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540705,35,'PORTO FERREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540754,35,'POTIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540804,35,'POTIRENDABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540853,35,'PRACINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3540903,35,'PRADÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541000,35,'PRAIA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541059,35,'PRATÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541109,35,'PRESIDENTE ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541208,35,'PRESIDENTE BERNARDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541307,35,'PRESIDENTE EPITÁCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541406,35,'PRESIDENTE PRUDENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541505,35,'PRESIDENTE VENCESLAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541604,35,'PROMISSÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541653,35,'QUADRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541703,35,'QUATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541802,35,'QUEIROZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3541901,35,'QUELUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542008,35,'QUINTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542107,35,'RAFARD');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542206,35,'RANCHARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542305,35,'REDENÇÃO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542404,35,'REGENTE FEIJÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542503,35,'REGINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542602,35,'REGISTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542701,35,'RESTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542800,35,'RIBEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3542909,35,'RIBEIRÃO BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543006,35,'RIBEIRÃO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543105,35,'RIBEIRÃO CORRENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543204,35,'RIBEIRÃO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543238,35,'RIBEIRÃO DOS ÍNDIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543253,35,'RIBEIRÃO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543303,35,'RIBEIRÃO PIRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543402,35,'RIBEIRÃO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543501,35,'RIVERSUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543600,35,'RIFAINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543709,35,'RINCÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543808,35,'RINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3543907,35,'RIO CLARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544004,35,'RIO DAS PEDRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544103,35,'RIO GRANDE DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544202,35,'RIOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544251,35,'ROSANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544301,35,'ROSEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544400,35,'RUBIÁCEA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544509,35,'RUBINÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544608,35,'SABINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544707,35,'SAGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544806,35,'SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3544905,35,'SALES OLIVEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545001,35,'SALESÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545100,35,'SALMOURÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545159,35,'SALTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545209,35,'SALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545308,35,'SALTO DE PIRAPORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545407,35,'SALTO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545506,35,'SANDOVALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545605,35,'SANTA ADÉLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545704,35,'SANTA ALBERTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3545803,35,'SANTA BÁRBARA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546009,35,'SANTA BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546108,35,'SANTA CLARA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546207,35,'SANTA CRUZ DA CONCEIÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546256,35,'SANTA CRUZ DA ESPERANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546306,35,'SANTA CRUZ DAS PALMEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546405,35,'SANTA CRUZ DO RIO PARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546504,35,'SANTA ERNESTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546603,35,'SANTA FÉ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546702,35,'SANTA GERTRUDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546801,35,'SANTA ISABEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3546900,35,'SANTA LÚCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547007,35,'SANTA MARIA DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547106,35,'SANTA MERCEDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547205,35,'SANTANA DA PONTE PENSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547304,35,'SANTANA DE PARNAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547403,35,'SANTA RITA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547502,35,'SANTA RITA DO PASSA QUATRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547601,35,'SANTA ROSA DE VITERBO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547650,35,'SANTA SALETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547700,35,'SANTO ANASTÁCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547809,35,'SANTO ANDRÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3547908,35,'SANTO ANTÔNIO DA ALEGRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548005,35,'SANTO ANTÔNIO DE POSSE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548054,35,'SANTO ANTÔNIO DO ARACANGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548104,35,'SANTO ANTÔNIO DO JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548203,35,'SANTO ANTÔNIO DO PINHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548302,35,'SANTO EXPEDITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548401,35,'SANTÓPOLIS DO AGUAPEÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548500,35,'SANTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548609,35,'SÃO BENTO DO SAPUCAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548708,35,'SÃO BERNARDO DO CAMPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548807,35,'SÃO CAETANO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3548906,35,'SÃO CARLOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549003,35,'SÃO FRANCISCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549102,35,'SÃO JOÃO DA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549201,35,'SÃO JOÃO DAS DUAS PONTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549250,35,'SÃO JOÃO DE IRACEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549300,35,'SÃO JOÃO DO PAU D''ALHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549409,35,'SÃO JOAQUIM DA BARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549508,35,'SÃO JOSÉ DA BELA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549607,35,'SÃO JOSÉ DO BARREIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549706,35,'SÃO JOSÉ DO RIO PARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549805,35,'SÃO JOSÉ DO RIO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549904,35,'SÃO JOSÉ DOS CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3549953,35,'SÃO LOURENÇO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550001,35,'SÃO LUÍS DO PARAITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550100,35,'SÃO MANUEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550209,35,'SÃO MIGUEL ARCANJO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550308,35,'SÃO PAULO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550407,35,'SÃO PEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550506,35,'SÃO PEDRO DO TURVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550605,35,'SÃO ROQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550704,35,'SÃO SEBASTIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550803,35,'SÃO SEBASTIÃO DA GRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3550902,35,'SÃO SIMÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551009,35,'SÃO VICENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551108,35,'SARAPUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551207,35,'SARUTAIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551306,35,'SEBASTIANÓPOLIS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551405,35,'SERRA AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551504,35,'SERRANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551603,35,'SERRA NEGRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551702,35,'SERTÃOZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551801,35,'SETE BARRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3551900,35,'SEVERÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552007,35,'SILVEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552106,35,'SOCORRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552205,35,'SOROCABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552304,35,'SUD MENNUCCI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552403,35,'SUMARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552502,35,'SUZANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552551,35,'SUZANÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552601,35,'TABAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552700,35,'TABATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552809,35,'TABOÃO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3552908,35,'TACIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553005,35,'TAGUAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553104,35,'TAIAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553203,35,'TAIÚVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553302,35,'TAMBAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553401,35,'TANABI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553500,35,'TAPIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553609,35,'TAPIRATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553658,35,'TAQUARAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553708,35,'TAQUARITINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553807,35,'TAQUARITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553856,35,'TAQUARIVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553906,35,'TARABAI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3553955,35,'TARUMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554003,35,'TATUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554102,35,'TAUBATÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554201,35,'TEJUPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554300,35,'TEODORO SAMPAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554409,35,'TERRA ROXA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554508,35,'TIETÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554607,35,'TIMBURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554656,35,'TORRE DE PEDRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554706,35,'TORRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554755,35,'TRABIJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554805,35,'TREMEMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554904,35,'TRÊS FRONTEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3554953,35,'TUIUTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555000,35,'TUPÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555109,35,'TUPI PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555208,35,'TURIÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555307,35,'TURMALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555356,35,'UBARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555406,35,'UBATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555505,35,'UBIRAJARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555604,35,'UCHOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555703,35,'UNIÃO PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555802,35,'URÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3555901,35,'URU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556008,35,'URUPÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556107,35,'VALENTIM GENTIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556206,35,'VALINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556305,35,'VALPARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556354,35,'VARGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556404,35,'VARGEM GRANDE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556453,35,'VARGEM GRANDE PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556503,35,'VÁRZEA PAULISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556602,35,'VERA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556701,35,'VINHEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556800,35,'VIRADOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556909,35,'VISTA ALEGRE DO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3556958,35,'VITÓRIA BRASIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3557006,35,'VOTORANTIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3557105,35,'VOTUPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3557154,35,'ZACARIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3557204,35,'CHAVANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (3557303,35,'ESTIVA GERBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100103,41,'ABATIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100202,41,'ADRIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100301,41,'AGUDOS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100400,41,'ALMIRANTE TAMANDARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100459,41,'ALTAMIRA DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100509,41,'ALTÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100608,41,'ALTO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100707,41,'ALTO PIQUIRI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100806,41,'ALVORADA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4100905,41,'AMAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101002,41,'AMPÉRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101051,41,'ANAHY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101101,41,'ANDIRÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101150,41,'ÂNGULO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101200,41,'ANTONINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101309,41,'ANTÔNIO OLINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101408,41,'APUCARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101507,41,'ARAPONGAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101606,41,'ARAPOTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101655,41,'ARAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101705,41,'ARARUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101804,41,'ARAUCÁRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101853,41,'ARIRANHA DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4101903,41,'ASSAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102000,41,'ASSIS CHATEAUBRIAND');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102109,41,'ASTORGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102208,41,'ATALAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102307,41,'BALSA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102406,41,'BANDEIRANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102505,41,'BARBOSA FERRAZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102604,41,'BARRACÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102703,41,'BARRA DO JACARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102752,41,'BELA VISTA DA CAROBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102802,41,'BELA VISTA DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4102901,41,'BITURUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103008,41,'BOA ESPERANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103024,41,'BOA ESPERANÇA DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103040,41,'BOA VENTURA DE SÃO ROQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103057,41,'BOA VISTA DA APARECIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103107,41,'BOCAIÚVA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103156,41,'BOM JESUS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103206,41,'BOM SUCESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103222,41,'BOM SUCESSO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103305,41,'BORRAZÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103354,41,'BRAGANEY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103370,41,'BRASILÂNDIA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103404,41,'CAFEARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103453,41,'CAFELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103479,41,'CAFEZAL DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103503,41,'CALIFÓRNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103602,41,'CAMBARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103701,41,'CAMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103800,41,'CAMBIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103909,41,'CAMPINA DA LAGOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4103958,41,'CAMPINA DO SIMÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104006,41,'CAMPINA GRANDE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104055,41,'CAMPO BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104105,41,'CAMPO DO TENENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104204,41,'CAMPO LARGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104253,41,'CAMPO MAGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104303,41,'CAMPO MOURÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104402,41,'CÂNDIDO DE ABREU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104428,41,'CANDÓI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104451,41,'CANTAGALO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104501,41,'CAPANEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104600,41,'CAPITÃO LEÔNIDAS MARQUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104659,41,'CARAMBEÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104709,41,'CARLÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104808,41,'CASCAVEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4104907,41,'CASTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105003,41,'CATANDUVAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105102,41,'CENTENÁRIO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105201,41,'CERRO AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105300,41,'CÉU AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105409,41,'CHOPINZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105508,41,'CIANORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105607,41,'CIDADE GAÚCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105706,41,'CLEVELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105805,41,'COLOMBO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4105904,41,'COLORADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106001,41,'CONGONHINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106100,41,'CONSELHEIRO MAIRINCK');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106209,41,'CONTENDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106308,41,'CORBÉLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106407,41,'CORNÉLIO PROCÓPIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106456,41,'CORONEL DOMINGOS SOARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106506,41,'CORONEL VIVIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106555,41,'CORUMBATAÍ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106571,41,'CRUZEIRO DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106605,41,'CRUZEIRO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106704,41,'CRUZEIRO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106803,41,'CRUZ MACHADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106852,41,'CRUZMALTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4106902,41,'CURITIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107009,41,'CURIÚVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107108,41,'DIAMANTE DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107124,41,'DIAMANTE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107157,41,'DIAMANTE D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107207,41,'DOIS VIZINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107256,41,'DOURADINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107306,41,'DOUTOR CAMARGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107405,41,'ENÉAS MARQUES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107504,41,'ENGENHEIRO BELTRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107520,41,'ESPERANÇA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107538,41,'ENTRE RIOS DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107546,41,'ESPIGÃO ALTO DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107553,41,'FAROL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107603,41,'FAXINAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107652,41,'FAZENDA RIO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107702,41,'FÊNIX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107736,41,'FERNANDES PINHEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107751,41,'FIGUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107801,41,'FLORAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107850,41,'FLOR DA SERRA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4107900,41,'FLORESTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108007,41,'FLORESTÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108106,41,'FLÓRIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108205,41,'FORMOSA DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108304,41,'FOZ DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108320,41,'FRANCISCO ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108403,41,'FRANCISCO BELTRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108452,41,'FOZ DO JORDÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108502,41,'GENERAL CARNEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108551,41,'GODOY MOREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108601,41,'GOIOERÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108650,41,'GOIOXIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108700,41,'GRANDES RIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108809,41,'GUAÍRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108908,41,'GUAIRAÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4108957,41,'GUAMIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109005,41,'GUAPIRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109104,41,'GUAPOREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109203,41,'GUARACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109302,41,'GUARANIAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109401,41,'GUARAPUAVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109500,41,'GUARAQUEÇABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109609,41,'GUARATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109658,41,'HONÓRIO SERPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109708,41,'IBAITI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109757,41,'IBEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109807,41,'IBIPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4109906,41,'ICARAÍMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110003,41,'IGUARAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110052,41,'IGUATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110078,41,'IMBAÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110102,41,'IMBITUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110201,41,'INÁCIO MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110300,41,'INAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110409,41,'INDIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110508,41,'IPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110607,41,'IPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110656,41,'IRACEMA DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110706,41,'IRATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110805,41,'IRETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110904,41,'ITAGUAJÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4110953,41,'ITAIPULÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111001,41,'ITAMBARACÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111100,41,'ITAMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111209,41,'ITAPEJARA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111258,41,'ITAPERUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111308,41,'ITAÚNA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111407,41,'IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111506,41,'IVAIPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111555,41,'IVATÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111605,41,'IVATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111704,41,'JABOTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111803,41,'JACAREZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4111902,41,'JAGUAPITÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112009,41,'JAGUARIAÍVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112108,41,'JANDAIA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112207,41,'JANIÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112306,41,'JAPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112405,41,'JAPURÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112504,41,'JARDIM ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112603,41,'JARDIM OLINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112702,41,'JATAIZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112751,41,'JESUÍTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112801,41,'JOAQUIM TÁVORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112900,41,'JUNDIAÍ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4112959,41,'JURANDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113007,41,'JUSSARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113106,41,'KALORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113205,41,'LAPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113254,41,'LARANJAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113304,41,'LARANJEIRAS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113403,41,'LEÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113429,41,'LIDIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113452,41,'LINDOESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113502,41,'LOANDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113601,41,'LOBATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113700,41,'LONDRINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113734,41,'LUIZIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113759,41,'LUNARDELLI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113809,41,'LUPIONÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4113908,41,'MALLET');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114005,41,'MAMBORÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114104,41,'MANDAGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114203,41,'MANDAGUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114302,41,'MANDIRITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114351,41,'MANFRINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114401,41,'MANGUEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114500,41,'MANOEL RIBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114609,41,'MARECHAL CÂNDIDO RONDON');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114708,41,'MARIA HELENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114807,41,'MARIALVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4114906,41,'MARILÂNDIA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115002,41,'MARILENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115101,41,'MARILUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115200,41,'MARINGÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115309,41,'MARIÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115358,41,'MARIPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115408,41,'MARMELEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115457,41,'MARQUINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115507,41,'MARUMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115606,41,'MATELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115705,41,'MATINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115739,41,'MATO RICO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115754,41,'MAUÁ DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115804,41,'MEDIANEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115853,41,'MERCEDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4115903,41,'MIRADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116000,41,'MIRASELVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116059,41,'MISSAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116109,41,'MOREIRA SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116208,41,'MORRETES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116307,41,'MUNHOZ DE MELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116406,41,'NOSSA SENHORA DAS GRAÇAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116505,41,'NOVA ALIANÇA DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116604,41,'NOVA AMÉRICA DA COLINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116703,41,'NOVA AURORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116802,41,'NOVA CANTU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116901,41,'NOVA ESPERANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4116950,41,'NOVA ESPERANÇA DO SUDOESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117008,41,'NOVA FÁTIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117057,41,'NOVA LARANJEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117107,41,'NOVA LONDRINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117206,41,'NOVA OLÍMPIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117214,41,'NOVA SANTA BÁRBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117222,41,'NOVA SANTA ROSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117255,41,'NOVA PRATA DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117271,41,'NOVA TEBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117297,41,'NOVO ITACOLOMI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117305,41,'ORTIGUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117404,41,'OURIZONA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117453,41,'OURO VERDE DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117503,41,'PAIÇANDU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117602,41,'PALMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117701,41,'PALMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117800,41,'PALMITAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4117909,41,'PALOTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118006,41,'PARAÍSO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118105,41,'PARANACITY');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118204,41,'PARANAGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118303,41,'PARANAPOEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118402,41,'PARANAVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118451,41,'PATO BRAGADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118501,41,'PATO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118600,41,'PAULA FREITAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118709,41,'PAULO FRONTIN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118808,41,'PEABIRU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118857,41,'PEROBAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4118907,41,'PÉROLA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119004,41,'PÉROLA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119103,41,'PIÊN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119152,41,'PINHAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119202,41,'PINHALÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119251,41,'PINHAL DE SÃO BENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119301,41,'PINHÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119400,41,'PIRAÍ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119509,41,'PIRAQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119608,41,'PITANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119657,41,'PITANGUEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119707,41,'PLANALTINA DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119806,41,'PLANALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119905,41,'PONTA GROSSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4119954,41,'PONTAL DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120002,41,'PORECATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120101,41,'PORTO AMAZONAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120150,41,'PORTO BARREIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120200,41,'PORTO RICO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120309,41,'PORTO VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120333,41,'PRADO FERREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120358,41,'PRANCHITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120408,41,'PRESIDENTE CASTELO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120507,41,'PRIMEIRO DE MAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120606,41,'PRUDENTÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120655,41,'QUARTO CENTENÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120705,41,'QUATIGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120804,41,'QUATRO BARRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120853,41,'QUATRO PONTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4120903,41,'QUEDAS DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121000,41,'QUERÊNCIA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121109,41,'QUINTA DO SOL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121208,41,'QUITANDINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121257,41,'RAMILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121307,41,'RANCHO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121356,41,'RANCHO ALEGRE D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121406,41,'REALEZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121505,41,'REBOUÇAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121604,41,'RENASCENÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121703,41,'RESERVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121752,41,'RESERVA DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121802,41,'RIBEIRÃO CLARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4121901,41,'RIBEIRÃO DO PINHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122008,41,'RIO AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122107,41,'RIO BOM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122156,41,'RIO BONITO DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122172,41,'RIO BRANCO DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122206,41,'RIO BRANCO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122305,41,'RIO NEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122404,41,'ROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122503,41,'RONCADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122602,41,'RONDON');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122651,41,'ROSÁRIO DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122701,41,'SABÁUDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122800,41,'SALGADO FILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4122909,41,'SALTO DO ITARARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123006,41,'SALTO DO LONTRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123105,41,'SANTA AMÉLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123204,41,'SANTA CECÍLIA DO PAVÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123303,41,'SANTA CRUZ DE MONTE CASTELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123402,41,'SANTA FÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123501,41,'SANTA HELENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123600,41,'SANTA INÊS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123709,41,'SANTA ISABEL DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123808,41,'SANTA IZABEL DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123824,41,'SANTA LÚCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123857,41,'SANTA MARIA DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123907,41,'SANTA MARIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4123956,41,'SANTA MÔNICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124004,41,'SANTANA DO ITARARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124020,41,'SANTA TEREZA DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124053,41,'SANTA TEREZINHA DE ITAIPU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124103,41,'SANTO ANTÔNIO DA PLATINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124202,41,'SANTO ANTÔNIO DO CAIUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124301,41,'SANTO ANTÔNIO DO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124400,41,'SANTO ANTÔNIO DO SUDOESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124509,41,'SANTO INÁCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124608,41,'SÃO CARLOS DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124707,41,'SÃO JERÔNIMO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124806,41,'SÃO JOÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4124905,41,'SÃO JOÃO DO CAIUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125001,41,'SÃO JOÃO DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125100,41,'SÃO JOÃO DO TRIUNFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125209,41,'SÃO JORGE D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125308,41,'SÃO JORGE DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125357,41,'SÃO JORGE DO PATROCÍNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125407,41,'SÃO JOSÉ DA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125456,41,'SÃO JOSÉ DAS PALMEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125506,41,'SÃO JOSÉ DOS PINHAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125555,41,'SÃO MANOEL DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125605,41,'SÃO MATEUS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125704,41,'SÃO MIGUEL DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125753,41,'SÃO PEDRO DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125803,41,'SÃO PEDRO DO IVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4125902,41,'SÃO PEDRO DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126009,41,'SÃO SEBASTIÃO DA AMOREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126108,41,'SÃO TOMÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126207,41,'SAPOPEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126256,41,'SARANDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126272,41,'SAUDADE DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126306,41,'SENGÉS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126355,41,'SERRANÓPOLIS DO IGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126405,41,'SERTANEJA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126504,41,'SERTANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126603,41,'SIQUEIRA CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126652,41,'SULINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126678,41,'TAMARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126702,41,'TAMBOARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126801,41,'TAPEJARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4126900,41,'TAPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127007,41,'TEIXEIRA SOARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127106,41,'TELÊMACO BORBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127205,41,'TERRA BOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127304,41,'TERRA RICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127403,41,'TERRA ROXA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127502,41,'TIBAGI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127601,41,'TIJUCAS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127700,41,'TOLEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127809,41,'TOMAZINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127858,41,'TRÊS BARRAS DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127882,41,'TUNAS DO PARANÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127908,41,'TUNEIRAS DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127957,41,'TUPÃSSI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4127965,41,'TURVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128005,41,'UBIRATÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128104,41,'UMUARAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128203,41,'UNIÃO DA VITÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128302,41,'UNIFLOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128401,41,'URAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128500,41,'WENCESLAU BRAZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128534,41,'VENTANIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128559,41,'VERA CRUZ DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128609,41,'VERÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128625,41,'ALTO PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128633,41,'DOUTOR ULYSSES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128658,41,'VIRMOND');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128708,41,'VITORINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4128807,41,'XAMBRÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200051,42,'ABDON BATISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200101,42,'ABELARDO LUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200200,42,'AGROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200309,42,'AGRONÔMICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200408,42,'ÁGUA DOCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200507,42,'ÁGUAS DE CHAPECÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200556,42,'ÁGUAS FRIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200606,42,'ÁGUAS MORNAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200705,42,'ALFREDO WAGNER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200754,42,'ALTO BELA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200804,42,'ANCHIETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4200903,42,'ANGELINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201000,42,'ANITA GARIBALDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201109,42,'ANITÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201208,42,'ANTÔNIO CARLOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201257,42,'APIÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201273,42,'ARABUTÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201307,42,'ARAQUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201406,42,'ARARANGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201505,42,'ARMAZÉM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201604,42,'ARROIO TRINTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201653,42,'ARVOREDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201703,42,'ASCURRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201802,42,'ATALANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201901,42,'AURORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4201950,42,'BALNEÁRIO ARROIO DO SILVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202008,42,'BALNEÁRIO CAMBORIÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202057,42,'BALNEÁRIO BARRA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202073,42,'BALNEÁRIO GAIVOTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202081,42,'BANDEIRANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202099,42,'BARRA BONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202107,42,'BARRA VELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202131,42,'BELA VISTA DO TOLDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202156,42,'BELMONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202206,42,'BENEDITO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202305,42,'BIGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202404,42,'BLUMENAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202438,42,'BOCAINA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202453,42,'BOMBINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202503,42,'BOM JARDIM DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202537,42,'BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202578,42,'BOM JESUS DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202602,42,'BOM RETIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202701,42,'BOTUVERÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202800,42,'BRAÇO DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202859,42,'BRAÇO DO TROMBUDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202875,42,'BRUNÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4202909,42,'BRUSQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203006,42,'CAÇADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203105,42,'CAIBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203154,42,'CALMON');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203204,42,'CAMBORIÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203253,42,'CAPÃO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203303,42,'CAMPO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203402,42,'CAMPO BELO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203501,42,'CAMPO ERÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203600,42,'CAMPOS NOVOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203709,42,'CANELINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203808,42,'CANOINHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203907,42,'CAPINZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4203956,42,'CAPIVARI DE BAIXO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204004,42,'CATANDUVAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204103,42,'CAXAMBU DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204152,42,'CELSO RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204178,42,'CERRO NEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204194,42,'CHAPADÃO DO LAGEADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204202,42,'CHAPECÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204251,42,'COCAL DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204301,42,'CONCÓRDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204350,42,'CORDILHEIRA ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204400,42,'CORONEL FREITAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204459,42,'CORONEL MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204509,42,'CORUPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204558,42,'CORREIA PINTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204608,42,'CRICIÚMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204707,42,'CUNHA PORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204756,42,'CUNHATAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204806,42,'CURITIBANOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4204905,42,'DESCANSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205001,42,'DIONÍSIO CERQUEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205100,42,'DONA EMMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205159,42,'DOUTOR PEDRINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205175,42,'ENTRE RIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205191,42,'ERMO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205209,42,'ERVAL VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205308,42,'FAXINAL DOS GUEDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205357,42,'FLOR DO SERTÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205407,42,'FLORIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205431,42,'FORMOSA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205456,42,'FORQUILHINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205506,42,'FRAIBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205555,42,'FREI ROGÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205605,42,'GALVÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205704,42,'GAROPABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205803,42,'GARUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4205902,42,'GASPAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206009,42,'GOVERNADOR CELSO RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206108,42,'GRÃO PARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206207,42,'GRAVATAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206306,42,'GUABIRUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206405,42,'GUARACIABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206504,42,'GUARAMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206603,42,'GUARUJÁ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206652,42,'GUATAMBÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206702,42,'HERVAL D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206751,42,'IBIAM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206801,42,'IBICARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4206900,42,'IBIRAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207007,42,'IÇARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207106,42,'ILHOTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207205,42,'IMARUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207304,42,'IMBITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207403,42,'IMBUIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207502,42,'INDAIAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207577,42,'IOMERÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207601,42,'IPIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207650,42,'IPORÃ DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207684,42,'IPUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207700,42,'IPUMIRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207759,42,'IRACEMINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207809,42,'IRANI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207858,42,'IRATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4207908,42,'IRINEÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208005,42,'ITÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208104,42,'ITAIÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208203,42,'ITAJAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208302,42,'ITAPEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208401,42,'ITAPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208450,42,'ITAPOÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208500,42,'ITUPORANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208609,42,'JABORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208708,42,'JACINTO MACHADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208807,42,'JAGUARUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208906,42,'JARAGUÁ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4208955,42,'JARDINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209003,42,'JOAÇABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209102,42,'JOINVILLE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209151,42,'JOSÉ BOITEUX');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209177,42,'JUPIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209201,42,'LACERDÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209300,42,'LAGES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209409,42,'LAGUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209458,42,'LAJEADO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209508,42,'LAURENTINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209607,42,'LAURO MULLER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209706,42,'LEBON RÉGIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209805,42,'LEOBERTO LEAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209854,42,'LINDÓIA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4209904,42,'LONTRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210001,42,'LUIZ ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210035,42,'LUZERNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210050,42,'MACIEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210100,42,'MAFRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210209,42,'MAJOR GERCINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210308,42,'MAJOR VIEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210407,42,'MARACAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210506,42,'MARAVILHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210555,42,'MAREMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210605,42,'MASSARANDUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210704,42,'MATOS COSTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210803,42,'MELEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210852,42,'MIRIM DOCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4210902,42,'MODELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211009,42,'MONDAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211058,42,'MONTE CARLO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211108,42,'MONTE CASTELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211207,42,'MORRO DA FUMAÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211256,42,'MORRO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211306,42,'NAVEGANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211405,42,'NOVA ERECHIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211454,42,'NOVA ITABERABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211504,42,'NOVA TRENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211603,42,'NOVA VENEZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211652,42,'NOVO HORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211702,42,'ORLEANS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211751,42,'OTACÍLIO COSTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211801,42,'OURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211850,42,'OURO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211876,42,'PAIAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211892,42,'PAINEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4211900,42,'PALHOÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212007,42,'PALMA SOLA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212056,42,'PALMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212106,42,'PALMITOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212205,42,'PAPANDUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212239,42,'PARAÍSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212254,42,'PASSO DE TORRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212270,42,'PASSOS MAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212304,42,'PAULO LOPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212403,42,'PEDRAS GRANDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212502,42,'PENHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212601,42,'PERITIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212700,42,'PETROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212809,42,'BALNEÁRIO PIÇARRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4212908,42,'PINHALZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213005,42,'PINHEIRO PRETO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213104,42,'PIRATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213153,42,'PLANALTO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213203,42,'POMERODE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213302,42,'PONTE ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213351,42,'PONTE ALTA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213401,42,'PONTE SERRADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213500,42,'PORTO BELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213609,42,'PORTO UNIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213708,42,'POUSO REDONDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213807,42,'PRAIA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4213906,42,'PRESIDENTE CASTELLO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214003,42,'PRESIDENTE GETÚLIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214102,42,'PRESIDENTE NEREU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214151,42,'PRINCESA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214201,42,'QUILOMBO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214300,42,'RANCHO QUEIMADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214409,42,'RIO DAS ANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214508,42,'RIO DO CAMPO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214607,42,'RIO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214706,42,'RIO DOS CEDROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214805,42,'RIO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4214904,42,'RIO FORTUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215000,42,'RIO NEGRINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215059,42,'RIO RUFINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215075,42,'RIQUEZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215109,42,'RODEIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215208,42,'ROMELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215307,42,'SALETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215356,42,'SALTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215406,42,'SALTO VELOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215455,42,'SANGÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215505,42,'SANTA CECÍLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215554,42,'SANTA HELENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215604,42,'SANTA ROSA DE LIMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215653,42,'SANTA ROSA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215679,42,'SANTA TEREZINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215687,42,'SANTA TEREZINHA DO PROGRESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215695,42,'SANTIAGO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215703,42,'SANTO AMARO DA IMPERATRIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215752,42,'SÃO BERNARDINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215802,42,'SÃO BENTO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4215901,42,'SÃO BONIFÁCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216008,42,'SÃO CARLOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216057,42,'SÃO CRISTOVÃO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216107,42,'SÃO DOMINGOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216206,42,'SÃO FRANCISCO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216255,42,'SÃO JOÃO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216305,42,'SÃO JOÃO BATISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216354,42,'SÃO JOÃO DO ITAPERIÚ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216404,42,'SÃO JOÃO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216503,42,'SÃO JOAQUIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216602,42,'SÃO JOSÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216701,42,'SÃO JOSÉ DO CEDRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216800,42,'SÃO JOSÉ DO CERRITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4216909,42,'SÃO LOURENÇO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217006,42,'SÃO LUDGERO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217105,42,'SÃO MARTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217154,42,'SÃO MIGUEL DA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217204,42,'SÃO MIGUEL DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217253,42,'SÃO PEDRO DE ALCÂNTARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217303,42,'SAUDADES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217402,42,'SCHROEDER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217501,42,'SEARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217550,42,'SERRA ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217600,42,'SIDERÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217709,42,'SOMBRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217758,42,'SUL BRASIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217808,42,'TAIÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217907,42,'TANGARÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4217956,42,'TIGRINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218004,42,'TIJUCAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218103,42,'TIMBÉ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218202,42,'TIMBÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218251,42,'TIMBÓ GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218301,42,'TRÊS BARRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218350,42,'TREVISO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218400,42,'TREZE DE MAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218509,42,'TREZE TÍLIAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218608,42,'TROMBUDO CENTRAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218707,42,'TUBARÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218756,42,'TUNÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218806,42,'TURVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218855,42,'UNIÃO DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218905,42,'URUBICI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4218954,42,'URUPEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219002,42,'URUSSANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219101,42,'VARGEÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219150,42,'VARGEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219176,42,'VARGEM BONITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219200,42,'VIDAL RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219309,42,'VIDEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219358,42,'VITOR MEIRELES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219408,42,'WITMARSUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219507,42,'XANXERÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219606,42,'XAVANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219705,42,'XAXIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4219853,42,'ZORTÉA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300034,43,'ACEGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300059,43,'ÁGUA SANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300109,43,'AGUDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300208,43,'AJURICABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300307,43,'ALECRIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300406,43,'ALEGRETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300455,43,'ALEGRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300471,43,'ALMIRANTE TAMANDARÉ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300505,43,'ALPESTRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300554,43,'ALTO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300570,43,'ALTO FELIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300604,43,'ALVORADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300638,43,'AMARAL FERRADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300646,43,'AMETISTA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300661,43,'ANDRÉ DA ROCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300703,43,'ANTA GORDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300802,43,'ANTÔNIO PRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300851,43,'ARAMBARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300877,43,'ARARICÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4300901,43,'ARATIBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301008,43,'ARROIO DO MEIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301057,43,'ARROIO DO SAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301073,43,'ARROIO DO PADRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301107,43,'ARROIO DOS RATOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301206,43,'ARROIO DO TIGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301305,43,'ARROIO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301404,43,'ARVOREZINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301503,43,'AUGUSTO PESTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301552,43,'ÁUREA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301602,43,'BAGÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301636,43,'BALNEÁRIO PINHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301651,43,'BARÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301701,43,'BARÃO DE COTEGIPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301750,43,'BARÃO DO TRIUNFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301800,43,'BARRACÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301859,43,'BARRA DO GUARITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301875,43,'BARRA DO QUARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301909,43,'BARRA DO RIBEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301925,43,'BARRA DO RIO AZUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4301958,43,'BARRA FUNDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302006,43,'BARROS CASSAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302055,43,'BENJAMIN CONSTANT DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302105,43,'BENTO GONÇALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302154,43,'BOA VISTA DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302204,43,'BOA VISTA DO BURICÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302220,43,'BOA VISTA DO CADEADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302238,43,'BOA VISTA DO INCRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302253,43,'BOA VISTA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302303,43,'BOM JESUS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302352,43,'BOM PRINCÍPIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302378,43,'BOM PROGRESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302402,43,'BOM RETIRO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302451,43,'BOQUEIRÃO DO LEÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302501,43,'BOSSOROCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302584,43,'BOZANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302600,43,'BRAGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302659,43,'BROCHIER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302709,43,'BUTIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302808,43,'CAÇAPAVA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4302907,43,'CACEQUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303004,43,'CACHOEIRA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303103,43,'CACHOEIRINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303202,43,'CACIQUE DOBLE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303301,43,'CAIBATÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303400,43,'CAIÇARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303509,43,'CAMAQUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303558,43,'CAMARGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303608,43,'CAMBARÁ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303673,43,'CAMPESTRE DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303707,43,'CAMPINA DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303806,43,'CAMPINAS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4303905,43,'CAMPO BOM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304002,43,'CAMPO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304101,43,'CAMPOS BORGES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304200,43,'CANDELÁRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304309,43,'CÂNDIDO GODÓI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304358,43,'CANDIOTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304408,43,'CANELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304507,43,'CANGUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304606,43,'CANOAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304614,43,'CANUDOS DO VALE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304622,43,'CAPÃO BONITO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304630,43,'CAPÃO DA CANOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304655,43,'CAPÃO DO CIPÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304663,43,'CAPÃO DO LEÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304671,43,'CAPIVARI DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304689,43,'CAPELA DE SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304697,43,'CAPITÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304705,43,'CARAZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304713,43,'CARAÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304804,43,'CARLOS BARBOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304853,43,'CARLOS GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304903,43,'CASCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4304952,43,'CASEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305009,43,'CATUÍPE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305108,43,'CAXIAS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305116,43,'CENTENÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305124,43,'CERRITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305132,43,'CERRO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305157,43,'CERRO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305173,43,'CERRO GRANDE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305207,43,'CERRO LARGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305306,43,'CHAPADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305355,43,'CHARQUEADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305371,43,'CHARRUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305405,43,'CHIAPETTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305439,43,'CHUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305447,43,'CHUVISCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305454,43,'CIDREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305504,43,'CIRÍACO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305587,43,'COLINAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305603,43,'COLORADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305702,43,'CONDOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305801,43,'CONSTANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305835,43,'COQUEIRO BAIXO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305850,43,'COQUEIROS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305871,43,'CORONEL BARROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305900,43,'CORONEL BICACO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305934,43,'CORONEL PILAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305959,43,'COTIPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4305975,43,'COXILHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306007,43,'CRISSIUMAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306056,43,'CRISTAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306072,43,'CRISTAL DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306106,43,'CRUZ ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306130,43,'CRUZALTENSE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306205,43,'CRUZEIRO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306304,43,'DAVID CANABARRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306320,43,'DERRUBADAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306353,43,'DEZESSEIS DE NOVEMBRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306379,43,'DILERMANDO DE AGUIAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306403,43,'DOIS IRMÃOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306429,43,'DOIS IRMÃOS DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306452,43,'DOIS LAJEADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306502,43,'DOM FELICIANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306551,43,'DOM PEDRO DE ALCÂNTARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306601,43,'DOM PEDRITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306700,43,'DONA FRANCISCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306734,43,'DOUTOR MAURÍCIO CARDOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306759,43,'DOUTOR RICARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306767,43,'ELDORADO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306809,43,'ENCANTADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306908,43,'ENCRUZILHADA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306924,43,'ENGENHO VELHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306932,43,'ENTRE-IJUÍS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306957,43,'ENTRE RIOS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4306973,43,'EREBANGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307005,43,'ERECHIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307054,43,'ERNESTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307104,43,'HERVAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307203,43,'ERVAL GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307302,43,'ERVAL SECO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307401,43,'ESMERALDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307450,43,'ESPERANÇA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307500,43,'ESPUMOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307559,43,'ESTAÇÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307609,43,'ESTÂNCIA VELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307708,43,'ESTEIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307807,43,'ESTRELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307815,43,'ESTRELA VELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307831,43,'EUGÊNIO DE CASTRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307864,43,'FAGUNDES VARELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4307906,43,'FARROUPILHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308003,43,'FAXINAL DO SOTURNO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308052,43,'FAXINALZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308078,43,'FAZENDA VILANOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308102,43,'FELIZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308201,43,'FLORES DA CUNHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308250,43,'FLORIANO PEIXOTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308300,43,'FONTOURA XAVIER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308409,43,'FORMIGUEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308433,43,'FORQUETINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308458,43,'FORTALEZA DOS VALOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308508,43,'FREDERICO WESTPHALEN');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308607,43,'GARIBALDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308656,43,'GARRUCHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308706,43,'GAURAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308805,43,'GENERAL CÂMARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308854,43,'GENTIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4308904,43,'GETÚLIO VARGAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309001,43,'GIRUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309050,43,'GLORINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309100,43,'GRAMADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309126,43,'GRAMADO DOS LOUREIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309159,43,'GRAMADO XAVIER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309209,43,'GRAVATAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309258,43,'GUABIJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309308,43,'GUAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309407,43,'GUAPORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309506,43,'GUARANI DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309555,43,'HARMONIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309571,43,'HERVEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309605,43,'HORIZONTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309654,43,'HULHA NEGRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309704,43,'HUMAITÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309753,43,'IBARAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309803,43,'IBIAÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309902,43,'IBIRAIARAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4309951,43,'IBIRAPUITÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310009,43,'IBIRUBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310108,43,'IGREJINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310207,43,'IJUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310306,43,'ILÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310330,43,'IMBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310363,43,'IMIGRANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310405,43,'INDEPENDÊNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310413,43,'INHACORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310439,43,'IPÊ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310462,43,'IPIRANGA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310504,43,'IRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310538,43,'ITAARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310553,43,'ITACURUBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310579,43,'ITAPUCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310603,43,'ITAQUI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310652,43,'ITATI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310702,43,'ITATIBA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310751,43,'IVORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310801,43,'IVOTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310850,43,'JABOTICABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310876,43,'JACUIZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4310900,43,'JACUTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311007,43,'JAGUARÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311106,43,'JAGUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311122,43,'JAQUIRANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311130,43,'JARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311155,43,'JÓIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311205,43,'JÚLIO DE CASTILHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311239,43,'LAGOA BONITA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311254,43,'LAGOÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311270,43,'LAGOA DOS TRÊS CANTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311304,43,'LAGOA VERMELHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311403,43,'LAJEADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311429,43,'LAJEADO DO BUGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311502,43,'LAVRAS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311601,43,'LIBERATO SALZANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311627,43,'LINDOLFO COLLOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311643,43,'LINHA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311700,43,'MACHADINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311718,43,'MAÇAMBARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311734,43,'MAMPITUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311759,43,'MANOEL VIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311775,43,'MAQUINÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311791,43,'MARATÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311809,43,'MARAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311908,43,'MARCELINO RAMOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4311981,43,'MARIANA PIMENTEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312005,43,'MARIANO MORO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312054,43,'MARQUES DE SOUZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312104,43,'MATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312138,43,'MATO CASTELHANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312153,43,'MATO LEITÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312179,43,'MATO QUEIMADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312203,43,'MAXIMILIANO DE ALMEIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312252,43,'MINAS DO LEÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312302,43,'MIRAGUAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312351,43,'MONTAURI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312377,43,'MONTE ALEGRE DOS CAMPOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312385,43,'MONTE BELO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312401,43,'MONTENEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312427,43,'MORMAÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312443,43,'MORRINHOS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312450,43,'MORRO REDONDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312476,43,'MORRO REUTER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312500,43,'MOSTARDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312609,43,'MUÇUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312617,43,'MUITOS CAPÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312625,43,'MULITERNO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312658,43,'NÃO-ME-TOQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312674,43,'NICOLAU VERGUEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312708,43,'NONOAI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312757,43,'NOVA ALVORADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312807,43,'NOVA ARAÇÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312906,43,'NOVA BASSANO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4312955,43,'NOVA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313003,43,'NOVA BRÉSCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313011,43,'NOVA CANDELÁRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313037,43,'NOVA ESPERANÇA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313060,43,'NOVA HARTZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313086,43,'NOVA PÁDUA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313102,43,'NOVA PALMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313201,43,'NOVA PETRÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313300,43,'NOVA PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313334,43,'NOVA RAMADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313359,43,'NOVA ROMA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313375,43,'NOVA SANTA RITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313391,43,'NOVO CABRAIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313409,43,'NOVO HAMBURGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313425,43,'NOVO MACHADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313441,43,'NOVO TIRADENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313466,43,'NOVO XINGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313490,43,'NOVO BARREIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313508,43,'OSÓRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313607,43,'PAIM FILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313656,43,'PALMARES DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313706,43,'PALMEIRA DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313805,43,'PALMITINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313904,43,'PANAMBI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4313953,43,'PANTANO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314001,43,'PARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314027,43,'PARAÍSO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314035,43,'PARECI NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314050,43,'PAROBÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314068,43,'PASSA SETE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314076,43,'PASSO DO SOBRADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314100,43,'PASSO FUNDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314134,43,'PAULO BENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314159,43,'PAVERAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314175,43,'PEDRAS ALTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314209,43,'PEDRO OSÓRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314308,43,'PEJUÇARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314407,43,'PELOTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314423,43,'PICADA CAFÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314456,43,'PINHAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314464,43,'PINHAL DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314472,43,'PINHAL GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314498,43,'PINHEIRINHO DO VALE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314506,43,'PINHEIRO MACHADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314555,43,'PIRAPÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314605,43,'PIRATINI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314704,43,'PLANALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314753,43,'POÇO DAS ANTAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314779,43,'PONTÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314787,43,'PONTE PRETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314803,43,'PORTÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4314902,43,'PORTO ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315008,43,'PORTO LUCENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315057,43,'PORTO MAUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315073,43,'PORTO VERA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315107,43,'PORTO XAVIER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315131,43,'POUSO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315149,43,'PRESIDENTE LUCENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315156,43,'PROGRESSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315172,43,'PROTÁSIO ALVES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315206,43,'PUTINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315305,43,'QUARAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315313,43,'QUATRO IRMÃOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315321,43,'QUEVEDOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315354,43,'QUINZE DE NOVEMBRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315404,43,'REDENTORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315453,43,'RELVADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315503,43,'RESTINGA SECA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315552,43,'RIO DOS ÍNDIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315602,43,'RIO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315701,43,'RIO PARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315750,43,'RIOZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315800,43,'ROCA SALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315909,43,'RODEIO BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4315958,43,'ROLADOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316006,43,'ROLANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316105,43,'RONDA ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316204,43,'RONDINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316303,43,'ROQUE GONZALES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316402,43,'ROSÁRIO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316428,43,'SAGRADA FAMÍLIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316436,43,'SALDANHA MARINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316451,43,'SALTO DO JACUÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316477,43,'SALVADOR DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316501,43,'SALVADOR DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316600,43,'SANANDUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316709,43,'SANTA BÁRBARA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316733,43,'SANTA CECÍLIA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316758,43,'SANTA CLARA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316808,43,'SANTA CRUZ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316907,43,'SANTA MARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316956,43,'SANTA MARIA DO HERVAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4316972,43,'SANTA MARGARIDA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317004,43,'SANTANA DA BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317103,43,'SANTANA DO LIVRAMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317202,43,'SANTA ROSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317251,43,'SANTA TEREZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317301,43,'SANTA VITÓRIA DO PALMAR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317400,43,'SANTIAGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317509,43,'SANTO ÂNGELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317558,43,'SANTO ANTÔNIO DO PALMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317608,43,'SANTO ANTÔNIO DA PATRULHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317707,43,'SANTO ANTÔNIO DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317756,43,'SANTO ANTÔNIO DO PLANALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317806,43,'SANTO AUGUSTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317905,43,'SANTO CRISTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4317954,43,'SANTO EXPEDITO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318002,43,'SÃO BORJA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318051,43,'SÃO DOMINGOS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318101,43,'SÃO FRANCISCO DE ASSIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318200,43,'SÃO FRANCISCO DE PAULA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318309,43,'SÃO GABRIEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318408,43,'SÃO JERÔNIMO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318424,43,'SÃO JOÃO DA URTIGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318432,43,'SÃO JOÃO DO POLÊSINE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318440,43,'SÃO JORGE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318457,43,'SÃO JOSÉ DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318465,43,'SÃO JOSÉ DO HERVAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318481,43,'SÃO JOSÉ DO HORTÊNCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318499,43,'SÃO JOSÉ DO INHACORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318507,43,'SÃO JOSÉ DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318606,43,'SÃO JOSÉ DO OURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318614,43,'SÃO JOSÉ DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318622,43,'SÃO JOSÉ DOS AUSENTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318705,43,'SÃO LEOPOLDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318804,43,'SÃO LOURENÇO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4318903,43,'SÃO LUIZ GONZAGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319000,43,'SÃO MARCOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319109,43,'SÃO MARTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319125,43,'SÃO MARTINHO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319158,43,'SÃO MIGUEL DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319208,43,'SÃO NICOLAU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319307,43,'SÃO PAULO DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319356,43,'SÃO PEDRO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319364,43,'SÃO PEDRO DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319372,43,'SÃO PEDRO DO BUTIÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319406,43,'SÃO PEDRO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319505,43,'SÃO SEBASTIÃO DO CAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319604,43,'SÃO SEPÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319703,43,'SÃO VALENTIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319711,43,'SÃO VALENTIM DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319737,43,'SÃO VALÉRIO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319752,43,'SÃO VENDELINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319802,43,'SÃO VICENTE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4319901,43,'SAPIRANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320008,43,'SAPUCAIA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320107,43,'SARANDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320206,43,'SEBERI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320230,43,'SEDE NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320263,43,'SEGREDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320305,43,'SELBACH');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320321,43,'SENADOR SALGADO FILHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320354,43,'SENTINELA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320404,43,'SERAFINA CORRÊA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320453,43,'SÉRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320503,43,'SERTÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320552,43,'SERTÃO SANTANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320578,43,'SETE DE SETEMBRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320602,43,'SEVERIANO DE ALMEIDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320651,43,'SILVEIRA MARTINS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320677,43,'SINIMBU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320701,43,'SOBRADINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320800,43,'SOLEDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320859,43,'TABAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4320909,43,'TAPEJARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321006,43,'TAPERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321105,43,'TAPES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321204,43,'TAQUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321303,43,'TAQUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321329,43,'TAQUARUÇU DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321352,43,'TAVARES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321402,43,'TENENTE PORTELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321436,43,'TERRA DE AREIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321451,43,'TEUTÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321469,43,'TIO HUGO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321477,43,'TIRADENTES DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321493,43,'TOROPI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321501,43,'TORRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321600,43,'TRAMANDAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321626,43,'TRAVESSEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321634,43,'TRÊS ARROIOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321667,43,'TRÊS CACHOEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321709,43,'TRÊS COROAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321808,43,'TRÊS DE MAIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321832,43,'TRÊS FORQUILHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321857,43,'TRÊS PALMEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321907,43,'TRÊS PASSOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4321956,43,'TRINDADE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322004,43,'TRIUNFO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322103,43,'TUCUNDUVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322152,43,'TUNAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322186,43,'TUPANCI DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322202,43,'TUPANCIRETÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322251,43,'TUPANDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322301,43,'TUPARENDI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322327,43,'TURUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322343,43,'UBIRETAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322350,43,'UNIÃO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322376,43,'UNISTALDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322400,43,'URUGUAIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322509,43,'VACARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322525,43,'VALE VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322533,43,'VALE DO SOL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322541,43,'VALE REAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322558,43,'VANINI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322608,43,'VENÂNCIO AIRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322707,43,'VERA CRUZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322806,43,'VERANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322855,43,'VESPASIANO CORREA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4322905,43,'VIADUTOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323002,43,'VIAMÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323101,43,'VICENTE DUTRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323200,43,'VICTOR GRAEFF');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323309,43,'VILA FLORES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323358,43,'VILA LÂNGARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323408,43,'VILA MARIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323457,43,'VILA NOVA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323507,43,'VISTA ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323606,43,'VISTA ALEGRE DO PRATA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323705,43,'VISTA GAÚCHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323754,43,'VITÓRIA DAS MISSÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323770,43,'WESTFALIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (4323804,43,'XANGRI-LÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000203,50,'ÁGUA CLARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000252,50,'ALCINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000609,50,'AMAMBAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000708,50,'ANASTÁCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000807,50,'ANAURILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000856,50,'ANGÉLICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5000906,50,'ANTÔNIO JOÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5001003,50,'APARECIDA DO TABOADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5001102,50,'AQUIDAUANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5001243,50,'ARAL MOREIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5001508,50,'BANDEIRANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5001904,50,'BATAGUASSU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002001,50,'BATAYPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002100,50,'BELA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002159,50,'BODOQUENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002209,50,'BONITO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002308,50,'BRASILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002407,50,'CAARAPÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002605,50,'CAMAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002704,50,'CAMPO GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002803,50,'CARACOL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002902,50,'CASSILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5002951,50,'CHAPADÃO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003108,50,'CORGUINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003157,50,'CORONEL SAPUCAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003207,50,'CORUMBÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003256,50,'COSTA RICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003306,50,'COXIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003454,50,'DEODÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003488,50,'DOIS IRMÃOS DO BURITI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003504,50,'DOURADINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003702,50,'DOURADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003751,50,'ELDORADO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003801,50,'FÁTIMA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5003900,50,'FIGUEIRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004007,50,'GLÓRIA DE DOURADOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004106,50,'GUIA LOPES DA LAGUNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004304,50,'IGUATEMI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004403,50,'INOCÊNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004502,50,'ITAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004601,50,'ITAQUIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004700,50,'IVINHEMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004809,50,'JAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5004908,50,'JARAGUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005004,50,'JARDIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005103,50,'JATEÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005152,50,'JUTI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005202,50,'LADÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005251,50,'LAGUNA CARAPÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005400,50,'MARACAJU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005608,50,'MIRANDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005681,50,'MUNDO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005707,50,'NAVIRAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5005806,50,'NIOAQUE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006002,50,'NOVA ALVORADA DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006200,50,'NOVA ANDRADINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006259,50,'NOVO HORIZONTE DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006309,50,'PARANAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006358,50,'PARANHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006408,50,'PEDRO GOMES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006606,50,'PONTA PORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5006903,50,'PORTO MURTINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007109,50,'RIBAS DO RIO PARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007208,50,'RIO BRILHANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007307,50,'RIO NEGRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007406,50,'RIO VERDE DE MATO GROSSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007505,50,'ROCHEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007554,50,'SANTA RITA DO PARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007695,50,'SÃO GABRIEL DO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007703,50,'SETE QUEDAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007802,50,'SELVÍRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007901,50,'SIDROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007935,50,'SONORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007950,50,'TACURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5007976,50,'TAQUARUSSU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5008008,50,'TERENOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5008305,50,'TRÊS LAGOAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5008404,50,'VICENTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100102,51,'ACORIZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100201,51,'ÁGUA BOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100250,51,'ALTA FLORESTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100300,51,'ALTO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100359,51,'ALTO BOA VISTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100409,51,'ALTO GARÇAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100508,51,'ALTO PARAGUAI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100607,51,'ALTO TAQUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5100805,51,'APIACÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101001,51,'ARAGUAIANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101209,51,'ARAGUAINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101258,51,'ARAPUTANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101308,51,'ARENÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101407,51,'ARIPUANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101605,51,'BARÃO DE MELGAÇO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101704,51,'BARRA DO BUGRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101803,51,'BARRA DO GARÇAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101852,51,'BOM JESUS DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5101902,51,'BRASNORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102504,51,'CÁCERES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102603,51,'CAMPINÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102637,51,'CAMPO NOVO DO PARECIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102678,51,'CAMPO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102686,51,'CAMPOS DE JÚLIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102694,51,'CANABRAVA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102702,51,'CANARANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102793,51,'CARLINDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5102850,51,'CASTANHEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103007,51,'CHAPADA DOS GUIMARÃES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103056,51,'CLÁUDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103106,51,'COCALINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103205,51,'COLÍDER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103254,51,'COLNIZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103304,51,'COMODORO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103353,51,'CONFRESA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103361,51,'CONQUISTA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103379,51,'COTRIGUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103403,51,'CUIABÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103437,51,'CURVELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103452,51,'DENISE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103502,51,'DIAMANTINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103601,51,'DOM AQUINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103700,51,'FELIZ NATAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103809,51,'FIGUEIRÓPOLIS D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103858,51,'GAÚCHA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103908,51,'GENERAL CARNEIRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5103957,51,'GLÓRIA D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104104,51,'GUARANTÃ DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104203,51,'GUIRATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104500,51,'INDIAVAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104526,51,'IPIRANGA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104542,51,'ITANHANGÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104559,51,'ITAÚBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104609,51,'ITIQUIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104807,51,'JACIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5104906,51,'JANGADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105002,51,'JAURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105101,51,'JUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105150,51,'JUÍNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105176,51,'JURUENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105200,51,'JUSCIMEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105234,51,'LAMBARI D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105259,51,'LUCAS DO RIO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105309,51,'LUCIÁRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105507,51,'VILA BELA DA SANTÍSSIMA TRINDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105580,51,'MARCELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105606,51,'MATUPÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105622,51,'MIRASSOL D''OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5105903,51,'NOBRES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106000,51,'NORTELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106109,51,'NOSSA SENHORA DO LIVRAMENTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106158,51,'NOVA BANDEIRANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106174,51,'NOVA NAZARÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106182,51,'NOVA LACERDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106190,51,'NOVA SANTA HELENA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106208,51,'NOVA BRASILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106216,51,'NOVA CANAÃ DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106224,51,'NOVA MUTUM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106232,51,'NOVA OLÍMPIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106240,51,'NOVA UBIRATÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106257,51,'NOVA XAVANTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106265,51,'NOVO MUNDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106273,51,'NOVO HORIZONTE DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106281,51,'NOVO SÃO JOAQUIM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106299,51,'PARANAÍTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106307,51,'PARANATINGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106315,51,'NOVO SANTO ANTÔNIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106372,51,'PEDRA PRETA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106422,51,'PEIXOTO DE AZEVEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106455,51,'PLANALTO DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106505,51,'POCONÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106653,51,'PONTAL DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106703,51,'PONTE BRANCA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106752,51,'PONTES E LACERDA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106778,51,'PORTO ALEGRE DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106802,51,'PORTO DOS GAÚCHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106828,51,'PORTO ESPERIDIÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5106851,51,'PORTO ESTRELA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107008,51,'POXORÉO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107040,51,'PRIMAVERA DO LESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107065,51,'QUERÊNCIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107107,51,'SÃO JOSÉ DOS QUATRO MARCOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107156,51,'RESERVA DO CABAÇAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107180,51,'RIBEIRÃO CASCALHEIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107198,51,'RIBEIRÃOZINHO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107206,51,'RIO BRANCO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107248,51,'SANTA CARMEM');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107263,51,'SANTO AFONSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107297,51,'SÃO JOSÉ DO POVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107305,51,'SÃO JOSÉ DO RIO CLARO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107354,51,'SÃO JOSÉ DO XINGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107404,51,'SÃO PEDRO DA CIPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107578,51,'RONDOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107602,51,'RONDONÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107701,51,'ROSÁRIO OESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107743,51,'SANTA CRUZ DO XINGU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107750,51,'SALTO DO CÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107768,51,'SANTA RITA DO TRIVELATO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107776,51,'SANTA TEREZINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107792,51,'SANTO ANTÔNIO DO LESTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107800,51,'SANTO ANTÔNIO DO LEVERGER');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107859,51,'SÃO FÉLIX DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107875,51,'SAPEZAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107883,51,'SERRA NOVA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107909,51,'SINOP');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107925,51,'SORRISO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107941,51,'TABAPORÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5107958,51,'TANGARÁ DA SERRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108006,51,'TAPURAH');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108055,51,'TERRA NOVA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108105,51,'TESOURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108204,51,'TORIXORÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108303,51,'UNIÃO DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108352,51,'VALE DE SÃO DOMINGOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108402,51,'VÁRZEA GRANDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108501,51,'VERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108600,51,'VILA RICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108808,51,'NOVA GUARITA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108857,51,'NOVA MARILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108907,51,'NOVA MARINGÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5108956,51,'NOVA MONTE VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200050,52,'ABADIA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200100,52,'ABADIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200134,52,'ACREÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200159,52,'ADELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200175,52,'ÁGUA FRIA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200209,52,'ÁGUA LIMPA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200258,52,'ÁGUAS LINDAS DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200308,52,'ALEXÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200506,52,'ALOÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200555,52,'ALTO HORIZONTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200605,52,'ALTO PARAÍSO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200803,52,'ALVORADA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200829,52,'AMARALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200852,52,'AMERICANO DO BRASIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5200902,52,'AMORINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201108,52,'ANÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201207,52,'ANHANGUERA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201306,52,'ANICUNS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201405,52,'APARECIDA DE GOIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201454,52,'APARECIDA DO RIO DOCE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201504,52,'APORÉ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201603,52,'ARAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201702,52,'ARAGARÇAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5201801,52,'ARAGOIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5202155,52,'ARAGUAPAZ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5202353,52,'ARENÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5202502,52,'ARUANÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5202601,52,'AURILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5202809,52,'AVELINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203104,52,'BALIZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203203,52,'BARRO ALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203302,52,'BELA VISTA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203401,52,'BOM JARDIM DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203500,52,'BOM JESUS DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203559,52,'BONFINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203575,52,'BONÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203609,52,'BRAZABRANTES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203807,52,'BRITÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203906,52,'BURITI ALEGRE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203939,52,'BURITI DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5203962,52,'BURITINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204003,52,'CABECEIRAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204102,52,'CACHOEIRA ALTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204201,52,'CACHOEIRA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204250,52,'CACHOEIRA DOURADA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204300,52,'CAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204409,52,'CAIAPÔNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204508,52,'CALDAS NOVAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204557,52,'CALDAZINHA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204607,52,'CAMPESTRE DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204656,52,'CAMPINAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204706,52,'CAMPINORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204805,52,'CAMPO ALEGRE DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204854,52,'CAMPO LIMPO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204904,52,'CAMPOS BELOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5204953,52,'CAMPOS VERDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205000,52,'CARMO DO RIO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205059,52,'CASTELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205109,52,'CATALÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205208,52,'CATURAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205307,52,'CAVALCANTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205406,52,'CERES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205455,52,'CEZARINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205471,52,'CHAPADÃO DO CÉU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205497,52,'CIDADE OCIDENTAL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205513,52,'COCALZINHO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205521,52,'COLINAS DO SUL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205703,52,'CÓRREGO DO OURO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205802,52,'CORUMBÁ DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5205901,52,'CORUMBAÍBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206206,52,'CRISTALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206305,52,'CRISTIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206404,52,'CRIXÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206503,52,'CROMÍNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206602,52,'CUMARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206701,52,'DAMIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206800,52,'DAMOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5206909,52,'DAVINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207105,52,'DIORAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207253,52,'DOVERLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207352,52,'EDEALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207402,52,'EDÉIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207501,52,'ESTRELA DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207535,52,'FAINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207600,52,'FAZENDA NOVA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207808,52,'FIRMINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5207907,52,'FLORES DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208004,52,'FORMOSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208103,52,'FORMOSO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208152,52,'GAMELEIRA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208301,52,'DIVINÓPOLIS DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208400,52,'GOIANÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208509,52,'GOIANDIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208608,52,'GOIANÉSIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208707,52,'GOIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208806,52,'GOIANIRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5208905,52,'GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209101,52,'GOIATUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209150,52,'GOUVELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209200,52,'GUAPÓ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209291,52,'GUARAÍTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209408,52,'GUARANI DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209457,52,'GUARINOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209606,52,'HEITORAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209705,52,'HIDROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209804,52,'HIDROLINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209903,52,'IACIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209937,52,'INACIOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5209952,52,'INDIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210000,52,'INHUMAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210109,52,'IPAMERI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210158,52,'IPIRANGA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210208,52,'IPORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210307,52,'ISRAELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210406,52,'ITABERAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210562,52,'ITAGUARI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210604,52,'ITAGUARU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210802,52,'ITAJÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5210901,52,'ITAPACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211008,52,'ITAPIRAPUÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211206,52,'ITAPURANGA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211305,52,'ITARUMÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211404,52,'ITAUÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211503,52,'ITUMBIARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211602,52,'IVOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211701,52,'JANDAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211800,52,'JARAGUÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5211909,52,'JATAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212006,52,'JAUPACI');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212055,52,'JESÚPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212105,52,'JOVIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212204,52,'JUSSARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212253,52,'LAGOA SANTA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212303,52,'LEOPOLDO DE BULHÕES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212501,52,'LUZIÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212600,52,'MAIRIPOTABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212709,52,'MAMBAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212808,52,'MARA ROSA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212907,52,'MARZAGÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5212956,52,'MATRINCHÃ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213004,52,'MAURILÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213053,52,'MIMOSO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213087,52,'MINAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213103,52,'MINEIROS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213400,52,'MOIPORÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213509,52,'MONTE ALEGRE DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213707,52,'MONTES CLAROS DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213756,52,'MONTIVIDIU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213772,52,'MONTIVIDIU DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213806,52,'MORRINHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213855,52,'MORRO AGUDO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5213905,52,'MOSSÂMEDES');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214002,52,'MOZARLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214051,52,'MUNDO NOVO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214101,52,'MUTUNÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214408,52,'NAZÁRIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214507,52,'NERÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214606,52,'NIQUELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214705,52,'NOVA AMÉRICA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214804,52,'NOVA AURORA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214838,52,'NOVA CRIXÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214861,52,'NOVA GLÓRIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214879,52,'NOVA IGUAÇU DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5214903,52,'NOVA ROMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215009,52,'NOVA VENEZA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215207,52,'NOVO BRASIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215231,52,'NOVO GAMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215256,52,'NOVO PLANALTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215306,52,'ORIZONA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215405,52,'OURO VERDE DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215504,52,'OUVIDOR');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215603,52,'PADRE BERNARDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215652,52,'PALESTINA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215702,52,'PALMEIRAS DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215801,52,'PALMELO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5215900,52,'PALMINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5216007,52,'PANAMÁ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5216304,52,'PARANAIGUARA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5216403,52,'PARAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5216452,52,'PEROLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5216809,52,'PETROLINA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5216908,52,'PILAR DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5217104,52,'PIRACANJUBA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5217203,52,'PIRANHAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5217302,52,'PIRENÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5217401,52,'PIRES DO RIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5217609,52,'PLANALTINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5217708,52,'PONTALINA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218003,52,'PORANGATU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218052,52,'PORTEIRÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218102,52,'PORTELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218300,52,'POSSE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218391,52,'PROFESSOR JAMIL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218508,52,'QUIRINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218607,52,'RIALMA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218706,52,'RIANÁPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218789,52,'RIO QUENTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218805,52,'RIO VERDE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5218904,52,'RUBIATABA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219001,52,'SANCLERLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219100,52,'SANTA BÁRBARA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219209,52,'SANTA CRUZ DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219258,52,'SANTA FÉ DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219308,52,'SANTA HELENA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219357,52,'SANTA ISABEL');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219407,52,'SANTA RITA DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219456,52,'SANTA RITA DO NOVO DESTINO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219506,52,'SANTA ROSA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219605,52,'SANTA TEREZA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219704,52,'SANTA TEREZINHA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219712,52,'SANTO ANTÔNIO DA BARRA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219738,52,'SANTO ANTÔNIO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219753,52,'SANTO ANTÔNIO DO DESCOBERTO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219803,52,'SÃO DOMINGOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5219902,52,'SÃO FRANCISCO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220009,52,'SÃO JOÃO D''ALIANÇA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220058,52,'SÃO JOÃO DA PARAÚNA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220108,52,'SÃO LUÍS DE MONTES BELOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220157,52,'SÃO LUÍZ DO NORTE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220207,52,'SÃO MIGUEL DO ARAGUAIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220264,52,'SÃO MIGUEL DO PASSA QUATRO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220280,52,'SÃO PATRÍCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220405,52,'SÃO SIMÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220454,52,'SENADOR CANEDO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220504,52,'SERRANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220603,52,'SILVÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220686,52,'SIMOLÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5220702,52,'SÍTIO D''ABADIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221007,52,'TAQUARAL DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221080,52,'TERESINA DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221197,52,'TEREZÓPOLIS DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221304,52,'TRÊS RANCHOS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221403,52,'TRINDADE');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221452,52,'TROMBAS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221502,52,'TURVÂNIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221551,52,'TURVELÂNDIA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221577,52,'UIRAPURU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221601,52,'URUAÇU');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221700,52,'URUANA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221809,52,'URUTAÍ');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221858,52,'VALPARAÍSO DE GOIÁS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5221908,52,'VARJÃO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5222005,52,'VIANÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5222054,52,'VICENTINÓPOLIS');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5222203,52,'VILA BOA');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5222302,52,'VILA PROPÍCIO');
INSERT INTO municipio (ID_MUNICIPIO,ID_UF,DESCRICAO) VALUES (5300108,53,'BRASÍLIA');

/*==============================================================*/
/* Table: MUNICIPIO_CURSO                                       */
/*==============================================================*/
create table MUNICIPIO_CURSO (
   ID_MUNICIPIO_CURSO   SERIAL not null,
   ID_MUNICIPIO         INT4                 not null,
   ID_CURSO             INT4                 not null,
   constraint PK_MUNICIPIO_CURSO primary key (ID_MUNICIPIO_CURSO)
);

/*==============================================================*/
/* Table: OFICINA                                               */
/*==============================================================*/
create table OFICINA (
   ID_OFICINA           SERIAL not null,
   ID_CURSO             INT4                 not null,
   NOM_OFICINA          VARCHAR(256)         not null,
   COD_OFICINA          VARCHAR(50)          not null,
   NUM_CARGA_HORARIA    INT2                 not null,
   constraint PK_OFICINA primary key (ID_OFICINA)
);

comment on column OFICINA.NUM_CARGA_HORARIA is
'Carga horário deve ser um número múltiplo de 4. Exemplo: 4, 8, 12 etc.';

/*==============================================================*/
/* Table: OPCAO_LISTA_CANDIDATO                                 */
/*==============================================================*/
create table OPCAO_LISTA_CANDIDATO (
   ID_OPCAO_LISTA_CAND  SERIAL not null,
   DSC_OPCAO_LIST_CAND  VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_OPCAO_LISTA_CANDIDATO primary key (ID_OPCAO_LISTA_CAND)
);

INSERT INTO opcao_lista_candidato (id_opcao_lista_cand, dsc_opcao_list_cand, flg_ativo) VALUES (1, 'Lista de Espera por Região', true);
INSERT INTO opcao_lista_candidato (id_opcao_lista_cand, dsc_opcao_list_cand, flg_ativo) VALUES (2, 'Lista de Espera Geral', true);
INSERT INTO opcao_lista_candidato (id_opcao_lista_cand, dsc_opcao_list_cand, flg_ativo) VALUES (3, 'Não Possui Lista de Espera', true);


SELECT setval('opcao_lista_candidato_id_opcao_lista_cand_seq', 3);

/*==============================================================*/
/* Table: ORGAO                                                 */
/*==============================================================*/
CREATE OR REPLACE FUNCTION sem_acento(text)  
    RETURNS text AS  
    $BODY$  
    select  
    translate($1,'áàâãäéèêëíìïóòôõöúùûüÁÀÂÃÄÉÈÊËÍÌÏÓÒÔÕÖÚÙÛÜçÇ','aaaaaeeeeiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcC');  
    $BODY$  
    LANGUAGE 'sql' IMMUTABLE STRICT;
create table ORGAO (
   ID_ORGAO             SERIAL not null,
   ID_ORGAO_PAI         INT4                 null,
   NOM_ORGAO            VARCHAR(255)         not null,
   LOGRADOURO           VARCHAR(255)         null,
   TEL_CONTATO          VARCHAR(255)         null,
   SGL_ORGAO            VARCHAR(255)         null,
   NOM_SIGLA            VARCHAR(255)         not null,
   constraint PK_ORGAO primary key (ID_ORGAO)
);

INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (4, 10000, 'SECRETARIA DE ASSUNTOS INTERNACIONAIS', ' ', NULL, ' SAIN', ' SAIN - SECRETARIA DE ASSUNTOS INTERNACIONAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (5, 10000, 'PROCURADORIA GERAL DA FAZENDA NACIONAL', '"Esplanada dos Ministérios - Bloco ""P"" - 8º andar - CEP 70048-900"', NULL, ' PGFN', ' PGFN - PROCURADORIA GERAL DA FAZENDA NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (6, 10000, 'SECRETARIA DE ACOMPANHAMENTO ECONÔMICO', ' ', NULL, ' SEAE', ' SEAE - SECRETARIA DE ACOMPANHAMENTO ECONÔMICO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (7, 10000, 'SECRETARIA DE POLÍTICA ECONÔMICA', ' ', NULL, ' SPE', ' SPE - SECRETARIA DE POLÍTICA ECONÔMICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10, 10000, 'CONSELHO MONETÁRIO NACIONAL', ' ', NULL, ' CMN', ' CMN - CONSELHO MONETÁRIO NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (12, 10000, 'CONSELHO DE CONTROLE DE ATIVIDADES FINANCEIRAS', 'SAS Q. 01 - Lote 3A - Térreo - CEP 70070-010', NULL, ' COAF', ' COAF - CONSELHO DE CONTROLE DE ATIVIDADES FINANCEIRAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (14, 13, 'FUNDAÇÃO INSTITUTO DE PESQUISA ECONÔMICA APLICADA', ' ', NULL, ' IPEA', ' IPEA - FUNDAÇÃO INSTITUTO DE PESQUISA ECONÔMICA APLICADA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (17, 356, 'MINISTÉRIO DA JUSTIÇA', '" Esplanada dos Ministérios - Bloco ""T"" - CEP 70064-900"', NULL, ' MJ', ' MJ - MINISTÉRIO DA JUSTIÇA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (18, 17, 'SECRETARIA DE DIREITO ECONÔMICO', ' ', NULL, ' SDE', ' SDE - SECRETARIA DE DIREITO ECONÔMICO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (19, 17, 'DEPARTAMENTO DE PROTEÇÃO E DEFESA ECONÔMICA ', ' ', NULL, ' DEPDE', ' DEPDE - DEPARTAMENTO DE PROTEÇÃO E DEFESA ECONÔMICA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (21, 17, 'DEPARTAMENTO DE POLICIA FEDERAL', ' ', NULL, ' DPF', ' DPF - DEPARTAMENTO DE POLICIA FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (23, 10017, 'PREFEITURAS MUNICIPAIS DO ESTADO DO ACRE', ' ', NULL, ' PREF ACRE', ' PREF ACRE - PREFEITURAS MUNICIPAIS DO ESTADO DO ACRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (25, 385, 'UNIDADE DE COORDENAÇÃO DE PROGRAMAS', ' ', NULL, ' UCP', ' UCP - UNIDADE DE COORDENAÇÃO DE PROGRAMAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (26, 356, 'SECRETARIA ESPECIAL DE DESENVOLVIMENTO URBANO', ' ', NULL, ' SEDU', ' SEDU - SECRETARIA ESPECIAL DE DESENVOLVIMENTO URBANO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (27, 461, 'EMPRESA BRASILEIRA DE INFRA-ESTRUTURA AEROPORTUÁRIA', ' ', NULL, ' INFRAERO', ' INFRAERO - EMPRESA BRASILEIRA DE INFRA-ESTRUTURA AEROPORTUÁRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (28, 356, 'MINISTÉRIO DO TRABALHO E EMPREGO', '" Esplanada dos Ministérios - Bloco ""F"" - CEP 70059-900"', NULL, ' MTE', ' MTE - MINISTÉRIO DO TRABALHO E EMPREGO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (31, 10001, 'GERÊNCIA DE TECNOLOGIA DA INFORMAÇÃO', ' ', NULL, ' GERTI', ' GERTI - GERÊNCIA DE TECNOLOGIA DA INFORMAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (32, 10001, 'PROCD-ESAF', ' ', NULL, ' PROCD', ' PROCD - PROCD-ESAF');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (38, 10001, 'PREFEITURA', ' ', NULL, ' PREFE', ' PREFE - PREFEITURA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (41, 10001, 'CEFOR', ' ', NULL, ' CEFOR', ' CEFOR - CEFOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (45, 10001, 'CENTRO REGIONAL DE TREINAMENTO NO DISTRITO FEDERAL', ' ', NULL, ' CENTRESAF-DF', ' CENTRESAF-DF - CENTRO REGIONAL DE TREINAMENTO NO DISTRITO FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (47, 10001, 'CENTRO REGIONAL DE TREINAMENTO NO PARÁ', ' ', NULL, ' CENTRESAF - PA', ' CENTRESAF - PA - CENTRO REGIONAL DE TREINAMENTO NO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (48, 10001, 'CENTRO REGIONAL DE TREINAMENTO EM PERNAMBUCO', ' ', NULL, ' CENTRESAF-PE', ' CENTRESAF-PE - CENTRO REGIONAL DE TREINAMENTO EM PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (50, 10001, 'CENTRO REGIONAL DE TREINAMENTO NO RIO DE JANEIRO', ' ', NULL, ' CENTRESAF-RJ', ' CENTRESAF-RJ - CENTRO REGIONAL DE TREINAMENTO NO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (53, 10001, 'CENTRO REGIONAL DE TREINAMENTO EM SÃO PAULO', ' ', NULL, ' CENTRESAF - SP', ' CENTRESAF - SP - CENTRO REGIONAL DE TREINAMENTO EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (55, 79, 'FUNDAÇÃO NACIONAL DE SAÚDE', ' ', NULL, ' FUNASA', ' FUNASA - FUNDAÇÃO NACIONAL DE SAÚDE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (57, 305, 'COORDENAÇÃO GERAL DE RECURSOS HUMANOS', ' ', NULL, ' COGRH', ' COGRH - COORDENAÇÃO GERAL DE RECURSOS HUMANOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (60, 356, 'SECRETARIA DE ADMINISTRAÇÃO', ' ', NULL, ' CCSA-PR', ' CCSA-PR - SECRETARIA DE ADMINISTRAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (62, 17, 'IMPRENSA NACIONAL ', ' ', NULL, ' IMPRENSA', ' IMPRENSA - IMPRENSA NACIONAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (63, 13, 'SECRETARIA DE ORÇAMENTO FEDERAL ', ' ', NULL, ' SOF', ' SOF - SECRETARIA DE ORÇAMENTO FEDERAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (66, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 10ª REGIÃO FISCAL', ' ', NULL, ' SRRF10', ' SRRF10 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 10ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (67, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO RIO GRANDE DO SUL', ' ', NULL, ' GRA/RS', ' GRA/RS - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (68, 5, 'PROCURADORIA DA FAZENDA NACIONAL NO RIO GRANDE DO SUL ', ' ', NULL, ' PRFN-RS', ' PRFN-RS - PROCURADORIA DA FAZENDA NACIONAL NO RIO GRANDE DO SUL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (69, 191, 'BASE AÉREA DE SANTA MARIA', ' ', NULL, ' INSS', ' INSS - BASE AÉREA DE SANTA MARIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (72, 376, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DE SAO PAULO', ' ', NULL, ' IFSP', ' IFSP - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DE SAO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (73, 192, 'INSTITUTO BRASÍLEIRO DO MEIO AMBIENTE', ' ', NULL, ' IBAMA', ' IBAMA - INSTITUTO BRASÍLEIRO DO MEIO AMBIENTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (76, 5, 'PROCURADORIA DA FAZENDA NACIONAL NO RIO GRANDE DO SUL ', ' ', NULL, ' PFN-RS', ' PFN-RS - PROCURADORIA DA FAZENDA NACIONAL NO RIO GRANDE DO SUL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (78, NULL, 'GERÊNCIA REGIONAL DO PATRIMÔNIO DA UNIÃO NO RIO GRANDE DO SUL', ' ', NULL, ' GRPU/RS', ' GRPU/RS - GERÊNCIA REGIONAL DO PATRIMÔNIO DA UNIÃO NO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (79, 356, 'MINISTÉRIO DA SAÚDE', '" Esplanada dos Ministérios - Bloco ""G"" - CEP 70058-900"', NULL, ' MS', ' MS - MINISTÉRIO DA SAÚDE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (80, 191, 'INSTITUTO NACIONAL DO SEGURO SOCIAL', ' ', NULL, ' INSS', ' INSS - INSTITUTO NACIONAL DO SEGURO SOCIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (83, 10017, 'SECRETARIA DE FAZENDA DO ESTADO DO ACRE ', ' ', NULL, ' SEFAZ-AC', ' SEFAZ-AC - SECRETARIA DE FAZENDA DO ESTADO DO ACRE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (84, 28, 'DELEGACIA REGIONAL DO TRABALHO', ' ', NULL, ' DRT-PA', ' DRT-PA - DELEGACIA REGIONAL DO TRABALHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (86, 85, 'DELEGACIA DA RECEITA FEDERAL - 2ª REGIÃO FISCAL ', ' ', NULL, ' DRF - 2ª RF', ' DRF - 2ª RF - DELEGACIA DA RECEITA FEDERAL - 2ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (87, NULL, 'SECRETARIA DE FINANÇAS DO MUNICÍPIO DE BELÉM ', ' ', NULL, ' SEFIM', ' SEFIM - SECRETARIA DE FINANÇAS DO MUNICÍPIO DE BELÉM ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (90, 10001, 'CEMAD', ' ', NULL, ' CEMAD', ' CEMAD - CEMAD');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (93, 10001, 'CENTRO REGIONAL DE TREINAMENTO NA BAHIA', ' ', NULL, ' CENTRESAF-BA', ' CENTRESAF-BA - CENTRO REGIONAL DE TREINAMENTO NA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (97, 10000, 'BANCO CENTRAL DO BRASIL', ' ', NULL, ' BACEN', ' BACEN - BANCO CENTRAL DO BRASIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (99, 275, 'INSPETORIA DA RECEITA FEDERAL', ' ', NULL, ' IRF', ' IRF - INSPETORIA DA RECEITA FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (102, 10014, 'SECRETARIA DE FAZENDA DO ESTADO DE RORAIMA ', ' ', NULL, ' SEFAZ-RR', ' SEFAZ-RR - SECRETARIA DE FAZENDA DO ESTADO DE RORAIMA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (103, 491, 'AGÊNCIA DE DESENVOLVIMENTO DA AMAZÔNIA ', ' ', NULL, ' ADA', ' ADA - AGÊNCIA DE DESENVOLVIMENTO DA AMAZÔNIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (104, 10001, 'CENTRESAF/DF - CURSO ABERTO', ' ', NULL, ' CENTRESAF-DF', ' CENTRESAF-DF - CENTRESAF/DF - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (106, 10001, 'CENTRESAF/CE - CURSO ABERTO', ' ', NULL, ' CENTRESAF-CE', ' CENTRESAF-CE - CENTRESAF/CE - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (107, 10001, 'CENTRESAF/PE - CURSO ABERTO', ' ', NULL, ' CENTRESAF-PE', ' CENTRESAF-PE - CENTRESAF/PE - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (109, 10001, 'CENTRESAF/RS - CURSO ABERTO', ' ', NULL, ' CENTRESAF-RS', ' CENTRESAF-RS - CENTRESAF/RS - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (116, 376, 'ESCOLA FAZENDÁRIA DO ESTADO DE PERNAMBUCO', ' ', NULL, ' ESAFAZ', ' ESAFAZ - ESCOLA FAZENDÁRIA DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (117, 10008, 'SECRETARIA DE FINANÇAS DA PARAÍBA', ' ', NULL, ' SECFIN-PB', ' SECFIN-PB - SECRETARIA DE FINANÇAS DA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (118, 172, 'TRIBUNAL REGIONAL ELEITORAL DE PERNAMBUCO ', ' ', NULL, ' TRE-PE', ' TRE-PE - TRIBUNAL REGIONAL ELEITORAL DE PERNAMBUCO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (121, NULL, 'PREFEITURA MUNICIPAL DE RECIFE ', ' ', NULL, ' PCR-PE', ' PCR-PE - PREFEITURA MUNICIPAL DE RECIFE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (122, 115, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO DE RECIFE', ' ', NULL, ' DRJ/REC', ' DRJ/REC - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO DE RECIFE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (123, 10005, 'TRIBUNAL REGIONAL DO TRABALHO DA 6ª REGIÃO', ' ', NULL, ' TRT- 6ª ', ' TRT- 6ª  - TRIBUNAL REGIONAL DO TRABALHO DA 6ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (125, 10012, 'SECRETARIA DE TRIBUTAÇÃO DO RIO GRANDE DO NORTE ', ' ', NULL, ' SECTRI-RN', ' SECTRI-RN - SECRETARIA DE TRIBUTAÇÃO DO RIO GRANDE DO NORTE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (127, 10019, 'TRIBUNAL DE CONTAS DO ESTADO DE PERNAMBUCO', ' Rua da Aurora, 885 - Boa Vista - CEP 50050-910', NULL, ' TCE-PE', ' TCE-PE - TRIBUNAL DE CONTAS DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (129, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO EM PERNAMBUCO', ' ', NULL, ' GRA/PE', ' GRA/PE - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO EM PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (131, NULL, 'TRIBUNAL DE JUSTIÇA FEDERAL 5ª REGIÃO', ' ', NULL, ' TJF-5ª', ' TJF-5ª - TRIBUNAL DE JUSTIÇA FEDERAL 5ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (133, 146, 'SECRETARIA MUNICIPAL DE FAZENDA ', ' ', NULL, ' SEMF-RJ', ' SEMF-RJ - SECRETARIA MUNICIPAL DE FAZENDA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (134, 192, 'AGÊNCIA NACIONAL DE ÁGUAS ', ' ', NULL, ' ANA', ' ANA - AGÊNCIA NACIONAL DE ÁGUAS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (135, 10003, 'AGÊNCIA NACIONAL DE TRANSPORTE AQUAVIÁRIOS ', ' ', NULL, ' ANTAQ', ' ANTAQ - AGÊNCIA NACIONAL DE TRANSPORTE AQUAVIÁRIOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (137, 10000, 'COMISSÃO DE VALORES MOBILIÁRIOS ', ' ', NULL, ' CVM', ' CVM - COMISSÃO DE VALORES MOBILIÁRIOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (143, 356, 'MINISTÉRIO DA AGRICULTURA, PECUÁRIA E ABASTECIMENTO', '"Esplanada dos Ministérios - Bloco ""D"" - CEP 70043-900"', NULL, ' MAPA', ' MAPA - MINISTÉRIO DA AGRICULTURA, PECUÁRIA E ABASTECIMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (144, 439, 'PETRÓLEO BRASILEIRO S/A', ' ', NULL, ' PETROBRAS', ' PETROBRAS - PETRÓLEO BRASILEIRO S/A');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (145, NULL, 'PREFEITURA MUNICIPAL DE VITÓRIA', ' ', NULL, ' PREF-VITÓRIA-ES', ' PREF-VITÓRIA-ES - PREFEITURA MUNICIPAL DE VITÓRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (147, 5, 'PROCURADORIA REGIONAL DA FAZENDA NACIONAL NO RIO DE JANEIRO', ' ', NULL, ' PRFN-RJ', ' PRFN-RJ - PROCURADORIA REGIONAL DA FAZENDA NACIONAL NO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (150, NULL, 'REDE FERROVIÁRIA FEDERAL S.A', ' ', NULL, ' RFFSA', ' RFFSA - REDE FERROVIÁRIA FEDERAL S.A');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (153, 10022, 'SECRETARIA DE ESTADO DA FAZENDA NO ESPÍRITO SANTO', ' ', NULL, ' SEFAZ-ES', ' SEFAZ-ES - SECRETARIA DE ESTADO DA FAZENDA NO ESPÍRITO SANTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (155, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 7ª REGIÃO FISCAL ', ' ', NULL, ' SRRF07', ' SRRF07 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 7ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (156, NULL, 'TRIBUNAL DE CONTAS DA UNIÃO', ' ', NULL, ' TCU', ' TCU - TRIBUNAL DE CONTAS DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (159, 10033, 'TRIBUNAL DE CONTAS DO MUNICÍPIO DO RIO DE JANEIRO ', ' ', NULL, ' TCM-RJ', ' TCM-RJ - TRIBUNAL DE CONTAS DO MUNICÍPIO DO RIO DE JANEIRO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (160, 10005, 'TRIBUNAL REGIONAL DO TRABALHO NO RIO DE JANEIRO ', ' ', NULL, ' TRT/RJ', ' TRT/RJ - TRIBUNAL REGIONAL DO TRABALHO NO RIO DE JANEIRO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (162, 10001, 'CENTRO DE EDITORAÇÃO E MATERIAL DIDÁTICO', ' ', NULL, ' CEMAD', ' CEMAD - CENTRO DE EDITORAÇÃO E MATERIAL DIDÁTICO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (163, NULL, 'SECRETARIA MUNICIPAL DE VITÓRIA', ' ', NULL, ' SECMU-ES', ' SECMU-ES - SECRETARIA MUNICIPAL DE VITÓRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (166, 356, 'CONTROLADORIA -GERAL DA UNIÃO ', ' ', NULL, ' CGU', ' CGU - CONTROLADORIA -GERAL DA UNIÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (167, 10011, 'GRUPO DE EDUCAÇÃO FISCAL', ' ', NULL, ' GEFE-MG', ' GEFE-MG - GRUPO DE EDUCAÇÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (169, 172, 'TRIBUNAL DE JUSTIÇA DO ESTADO DO RIO GRANDE DO SUL ', ' ', NULL, ' TJ-RS', ' TJ-RS - TRIBUNAL DE JUSTIÇA DO ESTADO DO RIO GRANDE DO SUL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (170, NULL, 'PREFEITURA MUNICIPAL DE RIO BRANCO', ' ', NULL, ' PREFM-AC', ' PREFM-AC - PREFEITURA MUNICIPAL DE RIO BRANCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (171, NULL, 'SECRETARIA DE ESTADO DE FINANÇAS E GESTÃO DO ACRE', ' ', NULL, ' SEFG-AC', ' SEFG-AC - SECRETARIA DE ESTADO DE FINANÇAS E GESTÃO DO ACRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (172, NULL, 'TRIBUNAL SUPERIOR ELEITORAL', ' ', NULL, ' TSE', ' TSE - TRIBUNAL SUPERIOR ELEITORAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (174, 10001, 'CENTRESAF/MG - CURSO ABERTO', ' ', NULL, ' CENTRESAF-MG', ' CENTRESAF-MG - CENTRESAF/MG - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (175, 10006, 'PROCURADORIA-GERAL DO DISTRITO FEDERAL ', ' ', NULL, ' PGDF', ' PGDF - PROCURADORIA-GERAL DO DISTRITO FEDERAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (177, 17, 'FUNDAÇÃO NACIONAL DO ÍNDIO ', ' ', NULL, ' FUNAI', ' FUNAI - FUNDAÇÃO NACIONAL DO ÍNDIO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (178, 275, 'COORDENAÇÃO-GERAL DE TRIBUTAÇÃO', ' ', NULL, ' COSIT', ' COSIT - COORDENAÇÃO-GERAL DE TRIBUTAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (180, 275, 'COORDENAÇÃO-GERAL DE ADMINISTRAÇÃO TRIBUTÁRIA ', ' ', NULL, ' CORAT', ' CORAT - COORDENAÇÃO-GERAL DE ADMINISTRAÇÃO TRIBUTÁRIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (181, 10000, 'BANCO DO BRASIL S/A', ' ', NULL, ' BB', ' BB - BANCO DO BRASIL S/A');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (182, 275, 'COORDENAÇÃO-GERAL DE PROGRAMAÇÃO E LOGÍSTICA ', ' ', NULL, ' COPOL', ' COPOL - COORDENAÇÃO-GERAL DE PROGRAMAÇÃO E LOGÍSTICA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (184, 10001, 'DIRED - CURSO ABERTO', ' ', NULL, ' DIRED', ' DIRED - DIRED - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (185, 275, 'COORDENAÇÃO-GERAL DE FISCALIZAÇÃO', ' ', NULL, ' COFIS', ' COFIS - COORDENAÇÃO-GERAL DE FISCALIZAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (186, 266, 'EMPRESA BRASILEIRA DE CORREIOS E TELEGRÁFOS', ' ', NULL, ' ECT', ' ECT - EMPRESA BRASILEIRA DE CORREIOS E TELEGRÁFOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (188, NULL, 'PREFEITURA MUNICIPAL DE DIADEMA', ' ', NULL, ' PREFDIADEMA', ' PREFDIADEMA - PREFEITURA MUNICIPAL DE DIADEMA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (191, 356, 'MINISTÉRIO DA PREVIDÊNCIA SOCIAL ', '" Esplanada dos Ministérios - Bloco ""F"" - CEP 70059-900"', NULL, ' MPS', ' MPS - MINISTÉRIO DA PREVIDÊNCIA SOCIAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (192, 356, 'MINISTÉRIO DO MEIO AMBIENTE', '" Esplanada dos Ministérios - Bloco ""B"" - CEP 70068-900"', NULL, ' MMA', ' MMA - MINISTÉRIO DO MEIO AMBIENTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (193, 192, 'COORDENADORIA DE AGROEXTRATIVISMO', ' ', NULL, ' CAGROEXT', ' CAGROEXT - COORDENADORIA DE AGROEXTRATIVISMO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (194, 275, 'CORREGEDORIA-GERAL DA RECEITA FEDERAL', ' ', NULL, ' COGER', ' COGER - CORREGEDORIA-GERAL DA RECEITA FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (198, NULL, 'PREFEITURA MUNICIPAL DE GUAIBA', ' ', NULL, ' PREF GUAIBA', ' PREF GUAIBA - PREFEITURA MUNICIPAL DE GUAIBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (199, 10002, 'CONSELHO NACIONAL DE DESENVOLVIMENTO TECNOLÓGICO ', ' ', NULL, ' CNPQ', ' CNPQ - CONSELHO NACIONAL DE DESENVOLVIMENTO TECNOLÓGICO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (201, 10002, 'INSTITUTO NACIONAL DE PESQUISAS ESPACIAIS ', ' ', NULL, ' INPE', ' INPE - INSTITUTO NACIONAL DE PESQUISAS ESPACIAIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (202, NULL, 'PREFEITURA MUNICIPAL DE FLORIANÓPOLIS ', ' ', NULL, ' PREF FLORIANÓPOLIS', ' PREF FLORIANÓPOLIS - PREFEITURA MUNICIPAL DE FLORIANÓPOLIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (204, 172, 'TRIBUNAL REGIONAL ELEITORAL DO PARANÁ', ' ', NULL, ' TRE-PR', ' TRE-PR - TRIBUNAL REGIONAL ELEITORAL DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (206, NULL, 'PREFEITURA MUNICIPAL DE LONDRINA', ' ', NULL, ' PREFLondrina-PR', ' PREFLondrina-PR - PREFEITURA MUNICIPAL DE LONDRINA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (207, NULL, 'TRIBUNAL DE ALÇADA DO ESTADO DO PARANÁ', ' ', NULL, ' TRIAL-PR', ' TRIAL-PR - TRIBUNAL DE ALÇADA DO ESTADO DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (209, 356, 'MINISTÉRIO DO TURISMO', ' ', NULL, ' MTUR', ' MTUR - MINISTÉRIO DO TURISMO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (212, 213, 'DELEGACIA DA RECEITA FEDERAL DE FORTALEZA ', ' ', NULL, ' DRF/FOR', ' DRF/FOR - DELEGACIA DA RECEITA FEDERAL DE FORTALEZA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (213, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 3ª REGIÃO FISCAL ', ' ', NULL, ' SRRF03', ' SRRF03 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 3ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (214, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO CEARÁ', ' ', NULL, ' GRA/CE', ' GRA/CE - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (215, 416, 'PROCURADORIA DA REPÚBLICA NO CEARÁ', ' ', NULL, ' PR-CE', ' PR-CE - PROCURADORIA DA REPÚBLICA NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (217, 79, 'FUNDAÇÃO NACIONAL DE SAÚDE - COORDENAÇÃO REGIONAL NO CEARÁ ', ' ', NULL, ' FUNASA-CE', ' FUNASA-CE - FUNDAÇÃO NACIONAL DE SAÚDE - COORDENAÇÃO REGIONAL NO CEARÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (218, 10028, 'SECRETARIA DE FAZENDA DO ESTADO DO PIAUÍ ', ' ', NULL, ' SEFAZ-PI', ' SEFAZ-PI - SECRETARIA DE FAZENDA DO ESTADO DO PIAUÍ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (220, 10021, 'SECRETARIA DE FINANÇAS DE FORTALEZA ', ' ', NULL, ' SEFIN-Fortaleza', ' SEFIN-Fortaleza - SECRETARIA DE FINANÇAS DE FORTALEZA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (222, 10023, 'GERÊNCIA DA RECEITA ESTADUAL DO MARANHÃO ', ' ', NULL, ' GERE-MA', ' GERE-MA - GERÊNCIA DA RECEITA ESTADUAL DO MARANHÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (223, NULL, 'SECRETARIA DE ADMINISTRAÇÃO DO ESTADO DO CEARÁ', ' ', NULL, ' SEAD-CE', ' SEAD-CE - SECRETARIA DE ADMINISTRAÇÃO DO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (225, NULL, 'COMISSAO ECONÔMICA PARA AMÉRICA LATINA E O CARIBE', ' ', NULL, ' CEPAL', ' CEPAL - COMISSAO ECONÔMICA PARA AMÉRICA LATINA E O CARIBE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (226, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DO ESPIRITO SANTO', ' ', NULL, ' TCE-ES', ' TCE-ES - TRIBUNAL DE CONTAS DO ESTADO DO ESPIRITO SANTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (228, 275, 'COORDENAÇÃO-GERAL DE ESTUDOS, PREVISÃO E ANÁLISE ', ' ', NULL, ' COGET', ' COGET - COORDENAÇÃO-GERAL DE ESTUDOS, PREVISÃO E ANÁLISE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (229, 356, 'ADVOCACIA-GERAL DA UNIÃO', ' ', NULL, ' AGU', ' AGU - ADVOCACIA-GERAL DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (230, 258, 'ALFÂNDEGA NO AEROPORTO INTERNACIONAL DE SALVADOR', ' ', NULL, ' ALF-SSA', ' ALF-SSA - ALFÂNDEGA NO AEROPORTO INTERNACIONAL DE SALVADOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (234, 258, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CAMAÇARI', ' Rua do Contorno - Centro Administrativo, s/nº - Dois de Julho - CEP 42800-610', NULL, ' DRF/CCI', ' DRF/CCI - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CAMAÇARI');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (235, 258, 'DELEGACIA DA RECEITA FEDERAL EM FEIRA DE SANTANA', 'Av. Getúlio Vargas, 195 - 1º ao 4º andar - Centro - CEP 44001-525', NULL, ' DRF - FEIRA DE SANTA', ' DRF - FEIRA DE SANTA - DELEGACIA DA RECEITA FEDERAL EM FEIRA DE SANTANA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (236, 258, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ILHÉUS', ' ', NULL, ' DRF/', ' DRF/ - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ILHÉUS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (238, 258, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ITABUNA', ' Av. Amélia Amado, 5 - Centro - CEP 45600-050', NULL, ' DRF/ITA', ' DRF/ITA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ITABUNA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (239, 258, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM VITÓRIA DA CONQUISTA', ' Praça Virgilio Ferraz. 32 - Centro - CEP 45000-901', NULL, ' DRF/VCA', ' DRF/VCA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM VITÓRIA DA CONQUISTA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (241, 79, 'FUNDAÇÃO NACIONAL DE SAÚDE ', ' ', NULL, ' FUNASA', ' FUNASA - FUNDAÇÃO NACIONAL DE SAÚDE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (242, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NA BAHIA', ' ', NULL, ' GRA/BA', ' GRA/BA - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (244, 258, 'INSPETORIA DO PORTO DE ARATU', ' ', NULL, ' IRF/ARU', ' IRF/ARU - INSPETORIA DO PORTO DE ARATU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (245, NULL, 'PREFEITURA MUNICIPAL DE ARACAJU', ' ', NULL, ' PREFAracaju-SE', ' PREFAracaju-SE - PREFEITURA MUNICIPAL DE ARACAJU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (246, NULL, 'PREFEITURA MUNICIPAL DE SALVADOR ', ' ', NULL, ' PREF SALVADOR', ' PREF SALVADOR - PREFEITURA MUNICIPAL DE SALVADOR ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (247, NULL, 'PREFEITURA MUNICIPAL DE AQUIDABÃ', ' ', NULL, ' PREFAquidabã-SE', ' PREFAquidabã-SE - PREFEITURA MUNICIPAL DE AQUIDABÃ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (248, NULL, 'PREFEITURA MUNICIPAL DE ITABAIANA', ' ', NULL, ' PREFItabaiana-SE', ' PREFItabaiana-SE - PREFEITURA MUNICIPAL DE ITABAIANA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (250, NULL, 'PREFEITURA MUNICIPAL DE LARANJEIRAS', ' ', NULL, ' PREFLaranjeiras-SE', ' PREFLaranjeiras-SE - PREFEITURA MUNICIPAL DE LARANJEIRAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (252, NULL, 'PREFEITURA MUNICIPAL DE NOSSA SENHORA DO SOCORRO', ' ', NULL, ' PREFN.SrªSocorro-SE', ' PREFN.SrªSocorro-SE - PREFEITURA MUNICIPAL DE NOSSA SENHORA DO SOCORRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (253, NULL, 'PREFEITURA MUNICIPAL DE PEDRA MOLE', ' ', NULL, ' PREFPedra Mole-SE', ' PREFPedra Mole-SE - PREFEITURA MUNICIPAL DE PEDRA MOLE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (255, 10031, 'SECRETARIA MUNICIPAL DE SAÚDE ', ' ', NULL, ' SEC BA', ' SEC BA - SECRETARIA MUNICIPAL DE SAÚDE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (256, 10007, 'SECRETARIA DA FAZENDA MUNICIPAL', ' ', NULL, ' SEFAZ MUN', ' SEFAZ MUN - SECRETARIA DA FAZENDA MUNICIPAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (259, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DA BAHIA', ' ', NULL, ' TCE-BA', ' TCE-BA - TRIBUNAL DE CONTAS DO ESTADO DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (260, NULL, 'TRIBUNAL DE CONTAS DO MUNICÍPIO DE SALVADOR', ' ', NULL, ' TCM/SAL', ' TCM/SAL - TRIBUNAL DE CONTAS DO MUNICÍPIO DE SALVADOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (261, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DE SERGIPE', ' ', NULL, ' TCE-SE', ' TCE-SE - TRIBUNAL DE CONTAS DO ESTADO DE SERGIPE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (263, 491, 'REGIÃO INTEGRADA DO DESENVOLVIMENTO DO ENTORNO', ' ', NULL, ' RIDE', ' RIDE - REGIÃO INTEGRADA DO DESENVOLVIMENTO DO ENTORNO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (265, NULL, 'EMPRESA LIMPEZA URBANA', ' ', NULL, ' EMLURB', ' EMLURB - EMPRESA LIMPEZA URBANA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (266, 356, 'MINISTÉRIO DAS COMUNICAÇÕES ', '" Esplanada dos Ministérios - Bloco ""R"" - CEP 70044-900"', NULL, ' MC', ' MC - MINISTÉRIO DAS COMUNICAÇÕES ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (267, NULL, 'PREFEITURA MUNICIPAL DE SANTA LUZIA ', ' ', NULL, ' PREF STª LUZIA', ' PREF STª LUZIA - PREFEITURA MUNICIPAL DE SANTA LUZIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (268, 376, 'FUNDAÇÃO INSTITUTO DE PESQUISAS ECONÔMICAS', ' ', NULL, ' FIPE', ' FIPE - FUNDAÇÃO INSTITUTO DE PESQUISAS ECONÔMICAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (269, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO MATO GROSSO DO SUL', ' ', NULL, ' GRA/MS', ' GRA/MS - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO MATO GROSSO DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (270, 13, 'SECRETARIA DE RECURSOS HUMANOS', ' ', NULL, ' SRH-MPOG', ' SRH-MPOG - SECRETARIA DE RECURSOS HUMANOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (272, 22, 'SUPERINTENDÊNCIA REGIONAL DA POLÍCIA FEDERAL DE MINAS GERAIS', ' ', NULL, ' 4ª SRPRF/MG', ' 4ª SRPRF/MG - SUPERINTENDÊNCIA REGIONAL DA POLÍCIA FEDERAL DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (273, NULL, 'BANCO MUNDIAL ', ' ', NULL, ' BIRD', ' BIRD - BANCO MUNDIAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (275, 10000, 'SECRETARIA DA RECEITA FEDERAL DO BRASIL', '', NULL, ' SRFB', ' SRFB - SECRETARIA DA RECEITA FEDERAL DO BRASIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (277, NULL, 'GERÊNCIA REGIONAL DE CONTROLE INTERNO', ' ', NULL, ' GRCI-SP', ' GRCI-SP - GERÊNCIA REGIONAL DE CONTROLE INTERNO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (278, 10000, 'CAIXA ECONÔMICA FEDERAL', ' ', NULL, ' CEF', ' CEF - CAIXA ECONÔMICA FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (279, NULL, 'CONTROLADORIA-GERAL DA UNIÃO EM SÃO PAULO', ' ', NULL, ' CGU-SP', ' CGU-SP - CONTROLADORIA-GERAL DA UNIÃO EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (281, 172, 'TRIBUNAL REGIONAL ELEITORAL DE MINAS GERAIS', ' ', NULL, ' TRE-MG', ' TRE-MG - TRIBUNAL REGIONAL ELEITORAL DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (283, NULL, 'APLAUSO ORGANIZAÇÃO DE EVENTOS LTDA', ' ', NULL, ' AOE', ' AOE - APLAUSO ORGANIZAÇÃO DE EVENTOS LTDA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (444, 305, 'INSTITUTO NACIONAL DA PROPRIEDADE INDUSTRIAL', ' ', NULL, ' INPI', ' INPI - INSTITUTO NACIONAL DA PROPRIEDADE INDUSTRIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (287, NULL, 'SINDICATO DOS AJUDANTES DE DESPACHANTES ADUANEIROS DE SANTOS ', '', NULL, ' SINDADA-SS-SP', ' SINDADA-SS-SP - SINDICATO DOS AJUDANTES DE DESPACHANTES ADUANEIROS DE SANTOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (289, 10006, 'SECRETARIA DA FAZENDA DO DISTRITO FEDERAL ', ' ', NULL, ' SEFAZ-DF', ' SEFAZ-DF - SECRETARIA DA FAZENDA DO DISTRITO FEDERAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (290, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DE ALAGOAS', ' ', NULL, ' CGU-AL', ' CGU-AL - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DE ALAGOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (292, 10000, 'EMPRESA GESTORA DE ATIVOS', ' ', NULL, ' EMGEA', ' EMGEA - EMPRESA GESTORA DE ATIVOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (293, 461, 'DEPARTAMENTO DE ADMINISTRAÇÃO INTERNA', ' ', NULL, ' DAI', ' DAI - DEPARTAMENTO DE ADMINISTRAÇÃO INTERNA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (295, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO PARANÁ', ' ', NULL, ' GRA/PR', ' GRA/PR - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (298, 152, 'GRA - PR/SC', ' ', NULL, ' GRA-PR/SC', ' GRA-PR/SC - GRA - PR/SC');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (299, 356, 'MINISTÉRIO DAS RELAÇÕES EXTERIORES', '"Palácio do Itamaraty - Esplanada dos Ministérios - Bloco ""H"" - CEP 70170-900"', NULL, ' MRE', ' MRE - MINISTÉRIO DAS RELAÇÕES EXTERIORES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (300, 356, 'PROCURADORIA-GERAL DA REPÚBLICA', ' ', NULL, ' PGR', ' PGR - PROCURADORIA-GERAL DA REPÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (301, 10001, 'DIRETORIA DE COOPERAÇÃO E PESQUISA', ' ', NULL, ' DIRCO', ' DIRCO - DIRETORIA DE COOPERAÇÃO E PESQUISA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (303, 376, 'UNIVERSIDADE FEDERAL FLUMINENSE', ' ', NULL, ' UFF', ' UFF - UNIVERSIDADE FEDERAL FLUMINENSE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (305, 356, 'MINISTÉRIO DO DESENVOLVIMENTO, INDÚSTRIA E COMÉRCIO EXTERIOR', '"Esplanada dos Ministérios - Bloco ""J"" - CEP 70053-900"', NULL, ' MDIC', ' MDIC - MINISTÉRIO DO DESENVOLVIMENTO, INDÚSTRIA E COMÉRCIO EXTERIOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (307, 10000, '1º CONSELHO DE CONTRIBUINTES', ' ', NULL, ' 1º CC', ' 1º CC - 1º CONSELHO DE CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (308, 10000, '2º CONSELHO DE CONTRIBUINTES', ' ', NULL, ' 2º CC', ' 2º CC - 2º CONSELHO DE CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (309, 10000, '3º CONSELHO DE CONTRIBUINTES', ' ', NULL, ' 3º CC', ' 3º CC - 3º CONSELHO DE CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (310, 396, 'PROCURADORIA DA REPÚBLICA NO ESTADO DE SÃO PAULO', ' ', NULL, ' PROC SP', ' PROC SP - PROCURADORIA DA REPÚBLICA NO ESTADO DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (312, 183, 'DELEGACIA DA RECEITA FEDERAL EM CASCÁVEL', ' ', NULL, ' DRF/CVL', ' DRF/CVL - DELEGACIA DA RECEITA FEDERAL EM CASCÁVEL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (314, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM LONDRINA ', 'Rua Brasil, 865 - Centro - CEP 86010-916', NULL, ' DRF/LON', ' DRF/LON - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM LONDRINA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (315, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM MARINGÁ ', 'Av. XV de Novembro, 527 - Centro - CEP 87013-909', NULL, ' DRF/MGA', ' DRF/MGA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM MARINGÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (316, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PARANAGUÁ', ' ', NULL, ' DRF PARANAGUÁ', ' DRF PARANAGUÁ - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PARANAGUÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (317, 183, 'DELEGACIA DA RECEITA FEDERAL EM PONTA GROSSA', ' ', NULL, ' DRF/PTG', ' DRF/PTG - DELEGACIA DA RECEITA FEDERAL EM PONTA GROSSA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (319, 183, 'DELEGACIA DA RECEITA FEDERAL EM JOINVILLE', ' ', NULL, ' DRF/JOI', ' DRF/JOI - DELEGACIA DA RECEITA FEDERAL EM JOINVILLE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (320, 183, 'DELEGACIA DA RECEITA FEDERAL EM BLUMENAU', ' ', NULL, ' DRF/BLU', ' DRF/BLU - DELEGACIA DA RECEITA FEDERAL EM BLUMENAU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (322, 183, 'INSPETORIA DA RECEITA FEDERAL EM FLORIANÓPOLIS', ' ', NULL, ' IRF/FNS', ' IRF/FNS - INSPETORIA DA RECEITA FEDERAL EM FLORIANÓPOLIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (324, 10008, 'SECRETARIA DE CONTROLE DE DESPESA PÚBLICA DO ESTADO DA PARAÍBA', ' ', NULL, ' SECCDP-PB', ' SECCDP-PB - SECRETARIA DE CONTROLE DE DESPESA PÚBLICA DO ESTADO DA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (325, 10019, 'PROCURADORIA-GERAL DE JUSTIÇA', ' ', NULL, ' PGJ-PE', ' PGJ-PE - PROCURADORIA-GERAL DE JUSTIÇA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (328, 10004, 'TRIBUNAL REGIONAL FEDERAL - 3ª REGIÃO ', ' ', NULL, ' TRF 3ª RF ', ' TRF 3ª RF  - TRIBUNAL REGIONAL FEDERAL - 3ª REGIÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (329, NULL, 'PREFEITURA MUNICIPAL DE JOÃO PESSOA ', ' ', NULL, ' PREFJOÃO PESSOA', ' PREFJOÃO PESSOA - PREFEITURA MUNICIPAL DE JOÃO PESSOA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (330, 376, 'ESCOLA AGROTÉCNICA FEDERAL DE CASTANHAL ', ' ', NULL, ' EAFC - PA', ' EAFC - PA - ESCOLA AGROTÉCNICA FEDERAL DE CASTANHAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (331, 439, 'AGÊNCIA NACIONAL DE ENERGIA ELÉTRICA', ' ', NULL, ' ANEEL', ' ANEEL - AGÊNCIA NACIONAL DE ENERGIA ELÉTRICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (333, 10032, 'SECRETARIA DE FAZENDA DO ESTADO DO TOCANTINS', ' ', NULL, ' ', '  - SECRETARIA DE FAZENDA DO ESTADO DO TOCANTINS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (334, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DE PERNAMBUCO ', ' ', NULL, ' IFPE', ' IFPE - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DE PERNAMBUCO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (336, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SÃO JOSÉ DOS CAMPOS ', 'Av. Nove de Julho, 332 - Vila Adyanna - CEP 12143-001', NULL, ' DRF/SJC', ' DRF/SJC - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SÃO JOSÉ DOS CAMPOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (337, 10006, 'SECRETARIA DE AÇÃO SOCIAL DO DISTRITO FEDERAL', ' ', NULL, ' SECAS-DF', ' SECAS-DF - SECRETARIA DE AÇÃO SOCIAL DO DISTRITO FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (339, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM RIBEIRÃO PRETO', 'Av. Dr. Francisco Junqueira, 2625 - Jd. Macedo - CEP 14091-902', NULL, ' DRF/POR', ' DRF/POR - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM RIBEIRÃO PRETO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (340, 366, 'DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA', ' ', NULL, ' DIPOL1', ' DIPOL1 - DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (341, 71, 'DELEGACIA ESPECIAL DE ASSUNTOS INTERNACIONAIS ', ' ', NULL, ' DEAI', ' DEAI - DELEGACIA ESPECIAL DE ASSUNTOS INTERNACIONAIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (343, 115, 'ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 4ª REGIÃO FISCAL', ' ', NULL, ' ESCOR4', ' ESCOR4 - ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 4ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (345, 10027, 'SECRETARIA DA FAZENDA DO ESTADO DO PARANÁ ', ' ', NULL, ' SEFAZ-PR', ' SEFAZ-PR - SECRETARIA DA FAZENDA DO ESTADO DO PARANÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (346, 491, 'DEPARTAMENTO NACIONAL DE OBRAS CONTRA AS SECAS', ' ', NULL, ' DNOCS', ' DNOCS - DEPARTAMENTO NACIONAL DE OBRAS CONTRA AS SECAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (348, NULL, 'UNIÃO EUROPÉIA', ' ', NULL, ' UE', ' UE - UNIÃO EUROPÉIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (350, 461, '6º SERVIÇO NACIONAL DE AVIAÇÃO CIVIL', ' ', NULL, 'SERAC 6', 'SERAC 6 - 6º SERVIÇO NACIONAL DE AVIAÇÃO CIVIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (352, 5, 'PROCURADORIA REGIONAL DA UNIÃO', ' ', NULL, ' PRU', ' PRU - PROCURADORIA REGIONAL DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (353, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DA PARAÍBA', ' ', NULL, ' CGU-PB', ' CGU-PB - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (356, NULL, 'PRESIDÊNCIA DA REPÚBLICA', ' ', NULL, ' PR', ' PR - PRESIDÊNCIA DA REPÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (357, 461, 'CENTRO GESTOR E OPERACIONAL DO SISTEMA DE PROTEÇÃO DA AMAZÔNIA', ' ', NULL, ' CENSIPAM', ' CENSIPAM - CENTRO GESTOR E OPERACIONAL DO SISTEMA DE PROTEÇÃO DA AMAZÔNIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (358, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM JUNDIAÍ', 'Av. Dr. Cavalcanti, 241 - Vila Arens - CEP 13201-003', NULL, ' DRF/JUN', ' DRF/JUN - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM JUNDIAÍ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (359, 356, 'MINISTÉRIO DA CULTURA', ' ', NULL, ' MINC', ' MINC - MINISTÉRIO DA CULTURA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (361, 10002, 'COMISSÃO NACIONAL DE ENERGIA NUCLEAR', ' ', NULL, ' CNEN', ' CNEN - COMISSÃO NACIONAL DE ENERGIA NUCLEAR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (363, 275, 'GABINETE', ' ', NULL, ' GAB-SRF', ' GAB-SRF - GABINETE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (445, 416, 'MINISTÉRIO PÚBLICO MILITAR', ' ', NULL, ' MPM', ' MPM - MINISTÉRIO PÚBLICO MILITAR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (366, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 1ª REGIÃO FISCAL', ' ', NULL, ' SRRF01', ' SRRF01 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 1ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (369, 10002, 'INSTITUTO NACIONAL DE PESQUISA DA AMAZÔNIA', ' ', NULL, ' INPA', ' INPA - INSTITUTO NACIONAL DE PESQUISA DA AMAZÔNIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (371, 166, 'CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DE RONDÔNIA', ' ', NULL, ' CGU-RO', ' CGU-RO - CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DE RONDÔNIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (373, 166, 'CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DO AMAPÁ ', ' ', NULL, ' CGU-AP', ' CGU-AP - CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DO AMAPÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (374, 356, 'MINISTÉRIO DO ESPORTE', '" Esplanada dos Ministérios - Bloco ""A"" - CEP 70054-906"', NULL, ' ME', ' ME - MINISTÉRIO DO ESPORTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (377, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DA BAHIA', ' Av. Frederico Pontes, s/nº - Ed. Min. da Fazenda, 2º andar, Sala 200 - Comércio - CEP 40015-902', NULL, ' CGU-BA', ' CGU-BA - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (378, 10024, 'SECRETARIA DA FAZENDA NO MATO GROSSO', ' ', NULL, ' SEFAZ-MT', ' SEFAZ-MT - SECRETARIA DA FAZENDA NO MATO GROSSO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (379, 10027, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DO PARANÁ', ' ', NULL, ' PFN-PR', ' PFN-PR - PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (381, 356, 'MINISTÉRIO DAS CIDADES', '"SAS Q. 01 - Lote 01/06 - Bloco ""H"" - Ed. Telemundi II - CEP 70070-010"', NULL, ' MCIDADES', ' MCIDADES - MINISTÉRIO DAS CIDADES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (382, 10022, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DO ESPÍRITO SANTO', ' ', NULL, ' PFN-ES', ' PFN-ES - PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DO ESPÍRITO SANTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (384, 71, 'AGÊNCIA DA RECEITA FEDERAL EM TABOÃO DA SERRA', ' ', NULL, ' ARF/TSR', ' ARF/TSR - AGÊNCIA DA RECEITA FEDERAL EM TABOÃO DA SERRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (385, 10000, 'SECRETARIA EXECUTIVA', ' ', NULL, ' SE', ' SE - SECRETARIA EXECUTIVA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (389, 79, 'NÚCLEO ESTADUAL DO MINISTÉRIO DA SAÚDE EM SÃO PAULO', ' ', NULL, ' MS-SP', ' MS-SP - NÚCLEO ESTADUAL DO MINISTÉRIO DA SAÚDE EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (390, 10001, 'DIREÇÃO-GERAL', ' ', NULL, ' DIRGE', ' DIRGE - DIREÇÃO-GERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (393, 416, 'PROCURADORIA REGIONAL DA REPÚBLICA - 2ª REGIÃO', ' ', NULL, ' PRR', ' PRR - PROCURADORIA REGIONAL DA REPÚBLICA - 2ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (394, 10026, 'PREFEITURA MUNICIPAL DE PARAUAPEBAS', ' ', NULL, ' PREF PARAUAPEBAS', ' PREF PARAUAPEBAS - PREFEITURA MUNICIPAL DE PARAUAPEBAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (395, 376, 'FUNDAÇÃO JOAQUIM NABUCO', ' ', NULL, ' FUNDAJ', ' FUNDAJ - FUNDAÇÃO JOAQUIM NABUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (398, NULL, 'SINDICATO DOS DESPACHANTES ADUANEIROS DO ESTADO DO RIO GRANDE DO SUL', ' ', NULL, ' SDA-RS', ' SDA-RS - SINDICATO DOS DESPACHANTES ADUANEIROS DO ESTADO DO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (399, 10027, 'UNIVERSIDADE ESTADUAL DE LONDRINA', ' ', NULL, ' UEL', ' UEL - UNIVERSIDADE ESTADUAL DE LONDRINA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (401, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CHUÍ', ' ', NULL, ' DRF/CHU', ' DRF/CHU - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CHUÍ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (402, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM URUGUAIANA', 'Rua Cônsul Antônio Mary Ulrich, 1149 - Centro - CEP 97510-070', NULL, ' DRF/URA', ' DRF/URA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM URUGUAIANA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (404, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PELOTAS', 'Rua Professor Araújo, 216 - Centro - CEP 96020-360', NULL, ' DRF/PEL', ' DRF/PEL - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PELOTAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (405, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTA MARIA', 'Rua Riachuelo, 80 - Centro - CEP 97050-010', NULL, ' DRF/STM', ' DRF/STM - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTA MARIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (407, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM NOVO HAMBURGO', 'Rua Tamandaré, 221 - Boa Vista - CEP 93410-150', NULL, ' DRF/NHO', ' DRF/NHO - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM NOVO HAMBURGO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (408, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM RIO GRANDE', ' ', NULL, ' DRF-RIO GRANDE', ' DRF-RIO GRANDE - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM RIO GRANDE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (409, 66, 'INSPETORIA DA RECEITA FEDERAL EM PORTO ALEGRE', ' ', NULL, ' IRF/POA', ' IRF/POA - INSPETORIA DA RECEITA FEDERAL EM PORTO ALEGRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (412, 10001, 'DIRETORIA DE ADMINISTRAÇÃO', ' ', NULL, ' DIRAD', ' DIRAD - DIRETORIA DE ADMINISTRAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (413, 439, 'AGÊNCIA NACIONAL DO PETRÓLEO, GÁS NATURAL E BIOCOMBUSTÍVEIS', ' ', NULL, ' ANP', ' ANP - AGÊNCIA NACIONAL DO PETRÓLEO, GÁS NATURAL E BIOCOMBUSTÍVEIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (414, 491, 'SECRETARIA DE DESENVOLVIMENTO DO CENTRO-OESTE', ' ', NULL, 'SCO', 'SCO - SECRETARIA DE DESENVOLVIMENTO DO CENTRO-OESTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (415, 10005, 'TRIBUNAL REGIONAL DO TRABALHO DA 9ª REGIÃO', ' ', NULL, ' TRT 9ª RF/PR', ' TRT 9ª RF/PR - TRIBUNAL REGIONAL DO TRABALHO DA 9ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (416, NULL, 'MINISTÉRIO PÚBLICO DA UNIÃO ', ' ', NULL, ' MPU', ' MPU - MINISTÉRIO PÚBLICO DA UNIÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (418, 85, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM MACAPÁ ', 'Rua Eliezer Levy, 1350 - Central - CEP 68900-083', NULL, ' DRF/MCA', ' DRF/MCA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM MACAPÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (419, 85, 'ALFÂNDEGA DO PORTO DE BELÉM', ' ', NULL, ' ALF/BEL ', ' ALF/BEL  - ALFÂNDEGA DO PORTO DE BELÉM');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (420, 85, 'ALFÂNDEGA DO AEROPORTO INTERNACIONAL DE BELÉM', ' ', NULL, ' ALF/AIB', ' ALF/AIB - ALFÂNDEGA DO AEROPORTO INTERNACIONAL DE BELÉM');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (423, 10009, 'SECRETARIA DE FAZENDA DO ESTADO DE ALAGOAS', ' ', NULL, ' SEFAZ-AL', ' SEFAZ-AL - SECRETARIA DE FAZENDA DO ESTADO DE ALAGOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (424, 10003, 'COMPANHIA DOCAS DO PARÁ', ' ', NULL, ' CDP', ' CDP - COMPANHIA DOCAS DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (426, 376, 'HOSPITAL NOSSA SENHORA DA CONCEIÇÃO S/A', ' ', NULL, ' HNSC', ' HNSC - HOSPITAL NOSSA SENHORA DA CONCEIÇÃO S/A');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (427, 275, 'COORDENAÇÃO-GERAL DE GESTÃO DE PESSOAS', ' ', NULL, ' COGEP-SRF', ' COGEP-SRF - COORDENAÇÃO-GERAL DE GESTÃO DE PESSOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (428, NULL, 'GERÊNCIA ESTADUAL DA ASSEFAZ EM SÃO PAULO', ' ', NULL, ' ASSEFAZ - SP', ' ASSEFAZ - SP - GERÊNCIA ESTADUAL DA ASSEFAZ EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (429, 416, 'PROCURADORIA DA REPÚBLICA NO PARANÁ', ' ', NULL, ' PR-PR', ' PR-PR - PROCURADORIA DA REPÚBLICA NO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (431, 5, 'ESCOLA SUPERIOR DA PROCURADORIA GERAL DA FAZENDA NACIONAL', ' ', NULL, ' ESPGFN', ' ESPGFN - ESCOLA SUPERIOR DA PROCURADORIA GERAL DA FAZENDA NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (433, 376, 'ESCOLA TÉCNICA FEDERAL DE MATO GROSSO', ' ', NULL, ' ETF - MT', ' ETF - MT - ESCOLA TÉCNICA FEDERAL DE MATO GROSSO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (434, 71, 'INSPETORIA DA RECEITA FEDERAL EM SÃO PAULO', ' ', NULL, ' IRF/SPO', ' IRF/SPO - INSPETORIA DA RECEITA FEDERAL EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (436, 356, 'MINISTÉRIO DO DESENVOLVIMENTO SOCIAL E COMBATE À FOME', ' ', NULL, ' MDS', ' MDS - MINISTÉRIO DO DESENVOLVIMENTO SOCIAL E COMBATE À FOME');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (437, 5, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DO CEARÁ', ' ', NULL, ' PFN-CE', ' PFN-CE - PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (439, 356, 'MINISTÉRIO DE MINAS E ENERGIA', '"Esplanada dos Ministérios - Bloco ""U"" - CEP 70065-900"', NULL, ' MME', ' MME - MINISTÉRIO DE MINAS E ENERGIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (440, 461, '2º COMANDO AÉREO REGIONAL EM RECIFE', ' ', NULL, ' 2º CAR-PE', ' 2º CAR-PE - 2º COMANDO AÉREO REGIONAL EM RECIFE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (441, NULL, 'FUNDAÇÃO GETÚLIO VARGAS', ' ', NULL, ' FGV', ' FGV - FUNDAÇÃO GETÚLIO VARGAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (443, 275, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO ', ' ', NULL, ' DRFJ', ' DRFJ - DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (449, 10033, 'TRIBUNAL DE CONTAS DO ESTADO DE PERNAMBUCO', ' ', NULL, ' TCE-PE', ' TCE-PE - TRIBUNAL DE CONTAS DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (450, NULL, 'BANCO INTERAMERICANO DE DESENVOLVIMENTO', ' ', NULL, ' BID', ' BID - BANCO INTERAMERICANO DE DESENVOLVIMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (453, 3, 'COORDENAÇÃO DE DESENVOLVIMENTO INSTITUCIONAL ', ' ', NULL, ' CODIN', ' CODIN - COORDENAÇÃO DE DESENVOLVIMENTO INSTITUCIONAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (454, 416, 'MINISTÉRIO PÚBLICO DO DISTRITO FEDERAL E TERRITÓRIOS ', ' ', NULL, ' MPDFT', ' MPDFT - MINISTÉRIO PÚBLICO DO DISTRITO FEDERAL E TERRITÓRIOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (455, NULL, 'PREFEITURA MUNICIPAL DE ARCOS', ' ', NULL, ' PREF ARCOS-MG', ' PREF ARCOS-MG - PREFEITURA MUNICIPAL DE ARCOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (457, 356, 'SUBSECRETARIA DE DIREITOS HUMANOS ', ' ', NULL, ' SEDH', ' SEDH - SUBSECRETARIA DE DIREITOS HUMANOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (460, NULL, 'CENTRO DE ESTUDOS E SISTEMAS AVANÇADOS DO RECIFE', ' ', NULL, ' CESAR', ' CESAR - CENTRO DE ESTUDOS E SISTEMAS AVANÇADOS DO RECIFE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (462, 491, 'COMPANHIA DE DESENVOLVIMENTO DOS VALES DO SÃO FRANCISCO E DO PARNAÍBA', ' ', NULL, ' CODEVASF', ' CODEVASF - COMPANHIA DE DESENVOLVIMENTO DOS VALES DO SÃO FRANCISCO E DO PARNAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (464, 10001, 'DIRAT - CURSO ABERTO', ' ', NULL, ' DIRAT', ' DIRAT - DIRAT - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (465, 10005, 'TRIBUNAL REGIONAL DO TRABALHO NA 3ª REGIÃO', ' ', NULL, ' TRT/MG', ' TRT/MG - TRIBUNAL REGIONAL DO TRABALHO NA 3ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (466, 17, 'CONSELHO NACIONAL DE COMBATE À PIRATARIA', ' ', NULL, ' CNCP', ' CNCP - CONSELHO NACIONAL DE COMBATE À PIRATARIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (467, 17, 'CONSELHO NACIONAL DE COMBATE À PIRATARIA', ' ', NULL, ' CNCP', ' CNCP - CONSELHO NACIONAL DE COMBATE À PIRATARIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (470, 10000, 'ASSESSORIA DE COMUNICAÇÃO SOCIAL', ' ', NULL, ' ACS', ' ACS - ASSESSORIA DE COMUNICAÇÃO SOCIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (473, 461, 'COMANDO MILITAR DO EXÉRCITO BRASILEIRO', ' ', NULL, ' ComEx', ' ComEx - COMANDO MILITAR DO EXÉRCITO BRASILEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (474, NULL, 'SINDICATO DOS SERVIDORES DA CGU NO RIO GRANDE DO SUL', ' ', NULL, ' UNACON-RS', ' UNACON-RS - SINDICATO DOS SERVIDORES DA CGU NO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (475, 461, 'CENTRO LOGÍSTICO DA AERONÁUTICA', ' ', NULL, ' CELOG', ' CELOG - CENTRO LOGÍSTICO DA AERONÁUTICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (477, 376, 'UNIVERSIDADE FEDERAL DO PARANÁ', ' ', NULL, ' UFP', ' UFP - UNIVERSIDADE FEDERAL DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (478, 10005, 'TRIBUNAL REGIONAL DO TRABALHO DA 4ª REGIÃO', ' ', NULL, ' TRT 4ª REGIÃO/RS', ' TRT 4ª REGIÃO/RS - TRIBUNAL REGIONAL DO TRABALHO DA 4ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (480, NULL, 'PROCURADORIA DA UNIÃO NO ESTADO DE MINAS GERAIS', ' ', NULL, ' PROC MG', ' PROC MG - PROCURADORIA DA UNIÃO NO ESTADO DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (481, 416, 'PROCURADORIA DA REPÚBLICA EM MINAS GERAIS', ' ', NULL, ' PR-MG', ' PR-MG - PROCURADORIA DA REPÚBLICA EM MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (483, 356, 'CONTROLADORIA-GERAL DA UNIÃO', ' ', NULL, ' CGU ', ' CGU  - CONTROLADORIA-GERAL DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (485, NULL, 'SUPERINTENDÊNCIA DE TRENS URBANOS DE JOÃO PESSOA', ' ', NULL, ' STU/JOP', ' STU/JOP - SUPERINTENDÊNCIA DE TRENS URBANOS DE JOÃO PESSOA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (487, 152, 'GÊRENCIA REGIONAL DE ADMINISTRAÇÃO', ' ', NULL, ' GRAS', ' GRAS - GÊRENCIA REGIONAL DE ADMINISTRAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (488, 66, 'DELEGACIA DA RECEITA FEDERAL EM SANTO ÂNGELO', ' Av. Brasil, 1400 - Centro - CEP 98801-590', NULL, ' DRF/SAO', ' DRF/SAO - DELEGACIA DA RECEITA FEDERAL EM SANTO ÂNGELO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (490, 227, 'DELEGACIA DA RECEITA FEDERAL EM BELO HORIZONTE ', ' ', NULL, ' DRF/BHE ', ' DRF/BHE  - DELEGACIA DA RECEITA FEDERAL EM BELO HORIZONTE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (491, 356, 'MINISTÉRIO DA INTEGRAÇÃO NACIONAL', '" Esplanada dos Ministérios - Bloco ""E"" - CEP 70067-901"', NULL, ' MI', ' MI - MINISTÉRIO DA INTEGRAÇÃO NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (492, NULL, 'FUNDAÇÃO ASSISTENCIAL DOS SERVIDORES DO MINISTÉRIO DA FAZENDA ', ' ', NULL, ' ASSEFAZ', ' ASSEFAZ - FUNDAÇÃO ASSISTENCIAL DOS SERVIDORES DO MINISTÉRIO DA FAZENDA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (494, 166, 'SECRETARIA DE PREVENÇÃO À CORRUPÇÃO E INFORMAÇÕES ESTRATÉGICAS', ' ', NULL, ' SPCI-CGU', ' SPCI-CGU - SECRETARIA DE PREVENÇÃO À CORRUPÇÃO E INFORMAÇÕES ESTRATÉGICAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (498, 71, 'DELEGACIA REGIONAL DE JULGAMENTO - SÃO PAULO II', ' ', NULL, ' DRJ/SP2', ' DRJ/SP2 - DELEGACIA REGIONAL DE JULGAMENTO - SÃO PAULO II');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (499, 79, 'AGÊNCIA NACIONAL DE SAÚDE SUPLEMENTAR', ' ', NULL, ' ANS', ' ANS - AGÊNCIA NACIONAL DE SAÚDE SUPLEMENTAR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (501, NULL, 'TCS/ INSTITUTO RUY BARBOSA', 'Avenida Teotônio Segurado, 102 Norte, Cj. 01, Lts. 1 e 2 - CEP 77006-002', NULL, ' IRB', ' IRB - TCS/ INSTITUTO RUY BARBOSA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (502, 10026, 'SECRETARIA DE ADMINISTRAÇÃO DO ESTADO DO PARÁ', ' ', NULL, ' SEAD', ' SEAD - SECRETARIA DE ADMINISTRAÇÃO DO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (506, 10014, 'SECRETARIA DE PLANEJAMENTO E DESENVOLVIMENTO DE RORAIMA', ' ', NULL, ' SEPLAN-RR', ' SEPLAN-RR - SECRETARIA DE PLANEJAMENTO E DESENVOLVIMENTO DE RORAIMA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (508, NULL, 'SINDICATO NACIONAL DOS AUDITORES-FISCAIS DA RECEITA FEDERAL - REGIONAL PERNAMBUCO', ' ', NULL, ' Unafisco-PE', ' Unafisco-PE - SINDICATO NACIONAL DOS AUDITORES-FISCAIS DA RECEITA FEDERAL - REGIONAL PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (509, 10000, 'ASSESSORIA DE COMUNICACAO SOCIAL', ' ', NULL, ' ASCOM-MF', ' ASCOM-MF - ASSESSORIA DE COMUNICACAO SOCIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (512, 172, 'TRIBUNAL REGIONAL ELEITORAL DO ESTADO DO CEARÁ', ' ', NULL, ' TRE-CE', ' TRE-CE - TRIBUNAL REGIONAL ELEITORAL DO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (513, 227, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM BELO HORIZONTE', ' ', NULL, ' DRJ/BHE', ' DRJ/BHE - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM BELO HORIZONTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (514, 275, 'COORDENAÇÃO-GERAL DE GESTÃO DE CADASTROS', ' ', NULL, ' CGGC', ' CGGC - COORDENAÇÃO-GERAL DE GESTÃO DE CADASTROS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (515, 10001, 'DIRED - CURSO ABERTO', ' ', NULL, ' CURSO ABERTO-DIRED', ' CURSO ABERTO-DIRED - DIRED - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (517, 79, 'NÚCLEO ESTADUAL DO MINISTÉRIO DA SAÚDE NO CEARÁ', ' ', NULL, ' NEC - CE', ' NEC - CE - NÚCLEO ESTADUAL DO MINISTÉRIO DA SAÚDE NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (518, 183, 'ALFÂNDEGA DO PORTO DE PARANAGUÁ', ' ', NULL, ' ALF/PGA', ' ALF/PGA - ALFÂNDEGA DO PORTO DE PARANAGUÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (520, 275, 'DIVISÃO DE CONTROL E COBRANÇA DE CRÉDITO TRIBUTÁRIO PJ', ' ', NULL, ' DIPEJ', ' DIPEJ - DIVISÃO DE CONTROL E COBRANÇA DE CRÉDITO TRIBUTÁRIO PJ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (521, NULL, 'PREFEITURA MUNICIPAL DE SERRA', ' ', NULL, ' PMS-SE', ' PMS-SE - PREFEITURA MUNICIPAL DE SERRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (524, 275, 'COORDENAÇÃO-GERAL DE ARRECADAÇÃO E COBRANÇA ', ' ', NULL, ' CODAC', ' CODAC - COORDENAÇÃO-GERAL DE ARRECADAÇÃO E COBRANÇA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (527, 275, 'COORDENACÃO-GERAL DE AUDITORIA INTERNA', ' ', NULL, ' AUDIT', ' AUDIT - COORDENACÃO-GERAL DE AUDITORIA INTERNA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (528, 275, 'ASSESSORIA DE ASSUNTOS INTERNACIONAIS', ' ', NULL, ' ASAIN-SRF', ' ASAIN-SRF - ASSESSORIA DE ASSUNTOS INTERNACIONAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (530, 275, 'DIVISÃO DE ACOMPANHAMENTO DO CONTENCIOSO JUDICIAL ', ' ', NULL, ' DICOJ', ' DICOJ - DIVISÃO DE ACOMPANHAMENTO DO CONTENCIOSO JUDICIAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (531, 10033, 'TRIBUNAIS DE CONTAS DOS ESTADOS', ' ', NULL, ' TCES', ' TCES - TRIBUNAIS DE CONTAS DOS ESTADOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (534, 305, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL', ' ', NULL, ' BNDES', ' BNDES - BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (535, 10021, 'TRIBUNAL DE CONTAS DOS MUNICÍPIOS DO ESTADO DO CEARÁ', ' ', NULL, ' TCM-CE', ' TCM-CE - TRIBUNAL DE CONTAS DOS MUNICÍPIOS DO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (536, 416, 'ESCOLA SUPERIOR DO MINISTÉRIO PÚBLICO DA UNIÃO', ' ', NULL, ' ESMPU', ' ESMPU - ESCOLA SUPERIOR DO MINISTÉRIO PÚBLICO DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (540, 28, 'DELEGACIA REGIONAL DO TRABALHO NO RIO DE JANEIRO', ' ', NULL, ' DRT-RJ', ' DRT-RJ - DELEGACIA REGIONAL DO TRABALHO NO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (541, 275, 'COORDENAÇÃO-GERAL DE CONTENCIOSO ADMINISTRATIVO E JUDICIAL ', ' ', NULL, ' COCAJ', ' COCAJ - COORDENAÇÃO-GERAL DE CONTENCIOSO ADMINISTRATIVO E JUDICIAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (543, 359, 'INSTITUTO RUI BARBOSA ', ' ', NULL, ' IRB', ' IRB - INSTITUTO RUI BARBOSA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (545, 275, 'COORDENAÇÃO-GERAL DE INTERAÇÃO COM O CIDADÃO', ' ', NULL, ' COINT', ' COINT - COORDENAÇÃO-GERAL DE INTERAÇÃO COM O CIDADÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (549, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTOS', 'Rua do Comércio, 86 - Centro - CEP 11010-922', NULL, ' DRF/STS', ' DRF/STS - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (551, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO EM SANTA CATARINA', ' ', NULL, ' GRA-SC', ' GRA-SC - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO EM SANTA CATARINA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (553, 71, 'DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA DA 8ª REGIÃO FISCAL ', ' ', NULL, ' DIPOL8', ' DIPOL8 - DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA DA 8ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (554, NULL, 'FIAT DO BRASIL S/A', ' ', NULL, ' FIAT', ' FIAT - FIAT DO BRASIL S/A');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (555, 275, 'COMITÊ GESTOR DO SIMPLES NACIONAL', ' ', NULL, ' CGSN - SRF', ' CGSN - SRF - COMITÊ GESTOR DO SIMPLES NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (557, 115, 'DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA NA 4ª REGIÃO FISCAL', ' ', NULL, ' DIPOL4', ' DIPOL4 - DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA NA 4ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (558, 115, 'DIVISÃO DE GESTÃO DE PESSOAS NA 4ª REGIÃO FISCAL', ' ', NULL, ' DIGEP4', ' DIGEP4 - DIVISÃO DE GESTÃO DE PESSOAS NA 4ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (560, 115, 'DIVISÃO DE ARRECADAÇÃO E COBRANÇA NA 4ª REGIÃO FISCAL', ' ', NULL, ' DIRAC4', ' DIRAC4 - DIVISÃO DE ARRECADAÇÃO E COBRANÇA NA 4ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (561, 115, 'DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA NA 4ª REGIÃO FISCAL', ' ', NULL, ' DIANA4', ' DIANA4 - DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA NA 4ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (563, 115, 'DIVISÃO DE FISCALIZAÇÃO NA 4ª REGIÃO FISCAL ', ' ', NULL, ' DIFIS4', ' DIFIS4 - DIVISÃO DE FISCALIZAÇÃO NA 4ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (564, 115, 'DIVISÃO DE TRIBUTAÇÃO NA 4ª REGIÃO FISCAL ', ' ', NULL, ' DISIT4', ' DISIT4 - DIVISÃO DE TRIBUTAÇÃO NA 4ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (566, 115, 'GABINETE DO SUPERINTENDENTE REGIONAL DA RECEITA FEDERAL 4ª REGIÃO FISCAL ', ' ', NULL, ' GABIN4', ' GABIN4 - GABINETE DO SUPERINTENDENTE REGIONAL DA RECEITA FEDERAL 4ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (568, 115, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM NATAL', ' Esplanada Silva Jardim, 83 - Ribeira - CEP 59012-090', NULL, 'DRF/NAT', 'DRF/NAT - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM NATAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (569, 115, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM JOÃO PESSOA', ' ', NULL, ' DRF/JPA', ' DRF/JPA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM JOÃO PESSOA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (574, 366, 'DIVISÃO DE INTERAÇÃO COM O CIDADÃO', ' ', NULL, ' DIVIC1', ' DIVIC1 - DIVISÃO DE INTERAÇÃO COM O CIDADÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (575, 71, 'DIVISÃO DE TRIBUTAÇÃO', ' ', NULL, ' DISIT8', ' DISIT8 - DIVISÃO DE TRIBUTAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (577, 71, 'DIVISÃO DE FISCALIZAÇÃO NA 8ª REGIÃO FISCAL', ' ', NULL, ' DIFIS8', ' DIFIS8 - DIVISÃO DE FISCALIZAÇÃO NA 8ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (578, 166, 'OUVIDORIA-GERAL DA UNIÃO ', ' ', NULL, ' OUVIDORIA GERAL', ' OUVIDORIA GERAL - OUVIDORIA-GERAL DA UNIÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (581, 10026, 'SECRETARIA DE ESTADO DE MEIO AMBIENTE', 'Travessa Lomas Valentinas, 2717 - Marco - CEP 66095-770', NULL, ' SEMA', ' SEMA - SECRETARIA DE ESTADO DE MEIO AMBIENTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (582, 3, 'COORDENAÇÃO-GERAL DE CONTROLE DA DÍVIDA PÚBLICA', ' ', NULL, ' CODIV', ' CODIV - COORDENAÇÃO-GERAL DE CONTROLE DA DÍVIDA PÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (583, 376, 'FUNDAÇÃO CESGRANRIO', ' ', NULL, ' CESGRANRIO', ' CESGRANRIO - FUNDAÇÃO CESGRANRIO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (585, NULL, 'CÂMARA AMERICANA NO ESTADO DA BAHIA', ' ', NULL, ' CÂMARA AMERICANA', ' CÂMARA AMERICANA - CÂMARA AMERICANA NO ESTADO DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (588, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DE GOIÁS', ' ', NULL, ' TCE-GO', ' TCE-GO - TRIBUNAL DE CONTAS DO ESTADO DE GOIÁS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (591, 71, 'ALFÂNDEGA NO AEROPORTO INTERNACIONAL DE SÃO PAULO', ' ', NULL, ' ALF/GRU', ' ALF/GRU - ALFÂNDEGA NO AEROPORTO INTERNACIONAL DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (592, 71, 'DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA', ' ', NULL, ' DIANA8', ' DIANA8 - DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (593, 10001, 'CEFOR - CURSO ABERTO', ' ', NULL, ' CEFOR/ESAF', ' CEFOR/ESAF - CEFOR - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (594, 376, 'HOSPITAL CRISTO REDENTOR S/A', ' ', NULL, ' HCR', ' HCR - HOSPITAL CRISTO REDENTOR S/A');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (595, 79, 'FUNDAÇÃO NACIONAL DE SAÚDE - COORDENAÇÃO REGIONAL DE SÃO PAULO', ' ', NULL, ' FUNASA-SP', ' FUNASA-SP - FUNDAÇÃO NACIONAL DE SAÚDE - COORDENAÇÃO REGIONAL DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (597, 376, 'INSTITUTO NACIONAL DE EDUCAÇÃO DE SURDOS NO RIO DE JANEIRO', ' ', NULL, ' INES', ' INES - INSTITUTO NACIONAL DE EDUCAÇÃO DE SURDOS NO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (598, 396, 'PROCURADORIA DA REPÚBLICA EM SANTA CATARINA ', ' ', NULL, ' PROC SC', ' PROC SC - PROCURADORIA DA REPÚBLICA EM SANTA CATARINA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (599, 491, 'SUPERINTENDÊNCIA DO DESENVOLVIMENTO DA AMAZÔNIA', ' ', NULL, ' SUDAM', ' SUDAM - SUPERINTENDÊNCIA DO DESENVOLVIMENTO DA AMAZÔNIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (601, 366, 'ALFANDEGA AEROPORTO INTERNACIONAL DE BRASÍLIA', ' ', NULL, ' ALF/BSB', ' ALF/BSB - ALFANDEGA AEROPORTO INTERNACIONAL DE BRASÍLIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (604, 10001, 'CEEAD - CURSO ABERTO', ' ', NULL, ' CEEAD/ESAF', ' CEEAD/ESAF - CEEAD - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (605, 71, 'DELEGACIA ESPECIAL DE INSTITUIÇÕES FINANCEIRAS EM SÃO PAULO', ' ', NULL, ' DEINF SP', ' DEINF SP - DELEGACIA ESPECIAL DE INSTITUIÇÕES FINANCEIRAS EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (606, 10035, 'SECRETARIA MUNICIPAL DE FINANÇAS DA PREFEITURA DA CIDADE DE SÃO PAULO', ' ', NULL, ' SEFIN SP', ' SEFIN SP - SECRETARIA MUNICIPAL DE FINANÇAS DA PREFEITURA DA CIDADE DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (607, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DO PARÁ', ' ', NULL, ' TCE-PA', ' TCE-PA - TRIBUNAL DE CONTAS DO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (609, 366, 'DIVISÃO DE TECNOLOGIA DA INFORMAÇÃO NA 1ª REGIÃO FISCAL', ' ', NULL, ' DITEC1', ' DITEC1 - DIVISÃO DE TECNOLOGIA DA INFORMAÇÃO NA 1ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (611, 359, 'FUNDAÇÃO BIBLIOTECA NACIONAL', ' ', NULL, ' FBN', ' FBN - FUNDAÇÃO BIBLIOTECA NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (612, 17, 'ARQUIVO NACIONAL', ' ', NULL, ' AN', ' AN - ARQUIVO NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (616, 275, 'COORDENAÇÃO-GERAL DE ATENDIMENTO E EDUCAÇÃO FISCAL', ' ', NULL, ' COAEF', ' COAEF - COORDENAÇÃO-GERAL DE ATENDIMENTO E EDUCAÇÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (618, 10000, 'CONSELHO ADMINISTRATIVO DE RECURSOS FISCAIS', ' ', NULL, ' CARF', ' CARF - CONSELHO ADMINISTRATIVO DE RECURSOS FISCAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (619, 10032, 'TRIBUNAL DE CONTAS DO ESTADO DO TOCANTINS', ' ', NULL, ' TCE-TO', ' TCE-TO - TRIBUNAL DE CONTAS DO ESTADO DO TOCANTINS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (621, 85, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM BOA VISTA', 'Rua Agnelo Bittencourt, 106 - Centro - CEP 69301-430', NULL, ' DRF/BVT', ' DRF/BVT - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM BOA VISTA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (622, 275, 'SUBSECRETARIA DE FISCALIZAÇÃO DA RECEITA FEDERAL DO BRASIL', ' ', NULL, ' SFRFB', ' SFRFB - SUBSECRETARIA DE FISCALIZAÇÃO DA RECEITA FEDERAL DO BRASIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (624, 275, 'SUBSECRETARIA DE ADMINISTRAÇÃO ADUANEIRA E RELAÇÕES INTERNACIONAIS', ' ', NULL, ' SUARI', ' SUARI - SUBSECRETARIA DE ADMINISTRAÇÃO ADUANEIRA E RELAÇÕES INTERNACIONAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (627, 10016, 'SECRETARIA DA FAZENDA DO ESTADO DE SÃO PAULO', ' ', NULL, ' SEFAZ-SP', ' SEFAZ-SP - SECRETARIA DA FAZENDA DO ESTADO DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (628, 624, 'COORDENAÇÃO-GERAL DE RELAÇÕES INTERNACIONAIS', ' ', NULL, ' CORIN', ' CORIN - COORDENAÇÃO-GERAL DE RELAÇÕES INTERNACIONAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (630, 10004, 'SUPERIOR TRIBUNAL MILITAR', ' ', NULL, ' STM', ' STM - SUPERIOR TRIBUNAL MILITAR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (631, 10000, 'ASSESSORIA ESPECIAL DE CONTROLE INTERNO', ' ', NULL, ' AESP', ' AESP - ASSESSORIA ESPECIAL DE CONTROLE INTERNO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (632, 152, 'COORDENAÇÃO-GERAL DE PLANEJAMENTO', ' ', NULL, ' COGPL', ' COGPL - COORDENAÇÃO-GERAL DE PLANEJAMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (634, 115, 'ALFÂNDEGA AEROPORTO INTERNACIONAL DOS GUARARAPES ', ' ', NULL, ' ALF/REC', ' ALF/REC - ALFÂNDEGA AEROPORTO INTERNACIONAL DOS GUARARAPES ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (636, NULL, 'PREFEITURA MUNICIPAL DE PORTO ALEGRE', ' ', NULL, ' PMPA', ' PMPA - PREFEITURA MUNICIPAL DE PORTO ALEGRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (638, 166, 'CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DO AMAZONAS', ' ', NULL, ' CGU-AM', ' CGU-AM - CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DO AMAZONAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (641, 275, 'COORDENAÇÃO DE PLANEJAMENTO DE EXECUÇÃO DE AUDITORIA', ' ', NULL, ' COPEA', ' COPEA - COORDENAÇÃO DE PLANEJAMENTO DE EXECUÇÃO DE AUDITORIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (642, NULL, 'PREFEITURA MUNICIPAL DE JUIZ DE FORA', ' ', NULL, ' PMJF', ' PMJF - PREFEITURA MUNICIPAL DE JUIZ DE FORA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (644, 115, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CARUARU', ' ', NULL, ' DRF/CRU', ' DRF/CRU - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CARUARU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (646, 366, 'SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES', ' ', NULL, ' SEMAC1', ' SEMAC1 - SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (647, NULL, 'PREFEITURA MUNICIPAL DE OURO PRETO', ' ', NULL, ' PMOURO PRETO', ' PMOURO PRETO - PREFEITURA MUNICIPAL DE OURO PRETO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (649, 192, 'DEPARTAMENTO DE ZONEAMENTO TERRITORIAL', ' ', NULL, ' DZT', ' DZT - DEPARTAMENTO DE ZONEAMENTO TERRITORIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (650, 71, 'DIVISÃO DE MAIORES CONTRIBUINTES DA 8ª REGIÃO FISCAL', ' ', NULL, ' DIMAC8', ' DIMAC8 - DIVISÃO DE MAIORES CONTRIBUINTES DA 8ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (651, 140, 'CENTRO DE PESQUISAS RENÉ RACHOU', ' ', NULL, ' CPQRR', ' CPQRR - CENTRO DE PESQUISAS RENÉ RACHOU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (654, 5, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DA BAHIA', ' ', NULL, ' PFN-BA', ' PFN-BA - PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (655, 71, 'DIVISÃO DE GESTÃO DE PESSOAS NA 8ª REGIÃO FISCAL', ' ', NULL, ' DIGEP8', ' DIGEP8 - DIVISÃO DE GESTÃO DE PESSOAS NA 8ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (657, 3, 'COORDENAÇÃO-GERAL DE ESTUDOS ECONÔMICOS-FISCAIS', ' ', NULL, ' CESEF', ' CESEF - COORDENAÇÃO-GERAL DE ESTUDOS ECONÔMICOS-FISCAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (658, 275, 'COORDENAÇÃO DE ORÇAMENTO, FINANÇAS E CONTABILIDADE', ' ', NULL, ' COFIC', ' COFIC - COORDENAÇÃO DE ORÇAMENTO, FINANÇAS E CONTABILIDADE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (659, 366, 'DIVISÃO DE TRIBUTAÇÃO DA 1ª REGIÃO FISCAL ', ' ', NULL, ' DISIT1', ' DISIT1 - DIVISÃO DE TRIBUTAÇÃO DA 1ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (661, 275, 'SUBSECRETARIA DE ADUANA E RELAÇÕES INTERNACIONAIS ', ' ', NULL, ' SARI', ' SARI - SUBSECRETARIA DE ADUANA E RELAÇÕES INTERNACIONAIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (663, 5, 'PROCURADORIA DA FAZENDA NACIONAL EM SÃO PAULO', ' ', NULL, ' PFN/SP-8ª RF', ' PFN/SP-8ª RF - PROCURADORIA DA FAZENDA NACIONAL EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (664, 29, 'GERÊNCIA DE SERVIÇOS', ' ', NULL, ' SUPRE', ' SUPRE - GERÊNCIA DE SERVIÇOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (665, NULL, 'ASSOCIAÇÃO DOS AUDITORES-FISCAIS DE BELÉM ', ' ', NULL, ' AFISB', ' AFISB - ASSOCIAÇÃO DOS AUDITORES-FISCAIS DE BELÉM ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (667, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DE MINAS GERAIS', ' ', NULL, ' IFMG', ' IFMG - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (668, 275, 'SUBSECRETARIA DE FISCALIZAÇÃO', ' ', NULL, ' SUFIS', ' SUFIS - SUBSECRETARIA DE FISCALIZAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (670, 10020, 'SECRETARIA DA FAZENDA DO ESTADO DO AMAZONAS', ' ', NULL, ' SEFAZ-AM', ' SEFAZ-AM - SECRETARIA DA FAZENDA DO ESTADO DO AMAZONAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (672, 29, 'SERPRO/SUPST/STDEATSTDRT', ' ', NULL, ' SUPST', ' SUPST - SERPRO/SUPST/STDEATSTDRT');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (674, 275, 'SUBSECRETARIA DE ARRECADAÇÃO E ATENDIMENTO', ' ', NULL, ' SUARA', ' SUARA - SUBSECRETARIA DE ARRECADAÇÃO E ATENDIMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (675, 376, 'UNIVERSIDADE FEDERAL DE VIÇOSA', ' ', NULL, ' UFV', ' UFV - UNIVERSIDADE FEDERAL DE VIÇOSA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (677, 275, 'COORDENAÇÃO-GERAL DE COOPERAÇÃO FISCAL E INTEGRAÇÃO', ' ', NULL, ' COCIF', ' COCIF - COORDENAÇÃO-GERAL DE COOPERAÇÃO FISCAL E INTEGRAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (678, 10035, 'TRIBUNAL REGIONAL FEDERAL - 4ª REGIÃO', ' ', NULL, ' TRF 4ª REGIÃO', ' TRF 4ª REGIÃO - TRIBUNAL REGIONAL FEDERAL - 4ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (680, 10030, 'SECRETARIA DE FAZENDA DO ESTADO DO RIO GRANDE DO SUL', ' ', NULL, ' SEFAZ-RS', ' SEFAZ-RS - SECRETARIA DE FAZENDA DO ESTADO DO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (681, 10000, 'DIVISÃO DE LICITAÇÕES', ' ', NULL, ' DILIC', ' DILIC - DIVISÃO DE LICITAÇÕES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (683, 227, ' DELEGACIA DA RECEITA FEDERAL EM VARGINHA', ' ', NULL, ' DRF-VAR', ' DRF-VAR -  DELEGACIA DA RECEITA FEDERAL EM VARGINHA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (684, NULL, 'SERVIÇO SOCIAL DA INDÚSTRIA', '', NULL, ' SESI', ' SESI - SERVIÇO SOCIAL DA INDÚSTRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (686, NULL, 'GERÊNCIA ESTADUAL DA ASSEFAZ NO RIO DE JANEIRO', ' ', NULL, ' ASSEFAZ - RJ', ' ASSEFAZ - RJ - GERÊNCIA ESTADUAL DA ASSEFAZ NO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (689, 13, 'SECRETARIA DE LOGÍSTICA E TECNOLOGIA DA INFORMAÇÃO', ' ', NULL, ' SLTI', ' SLTI - SECRETARIA DE LOGÍSTICA E TECNOLOGIA DA INFORMAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (690, 10027, 'TRIBUNAL DE CONTAS DO ESTADO DO PARANÁ', ' ', NULL, ' TCE-PR', ' TCE-PR - TRIBUNAL DE CONTAS DO ESTADO DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (693, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO NORTE DE MINAS GERAIS', ' ', NULL, ' IF MG N', ' IF MG N - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO NORTE DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (694, NULL, 'PREFEITURA MUNICIPAL DE ACAIACA', ' ', NULL, ' PMAc-MG', ' PMAc-MG - PREFEITURA MUNICIPAL DE ACAIACA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (695, NULL, 'INSTITUTO DE PREVIDÊNCIA MUNICIPAL DE GOVERNADOR VALADARES', ' ', NULL, ' IPREM/GV', ' IPREM/GV - INSTITUTO DE PREVIDÊNCIA MUNICIPAL DE GOVERNADOR VALADARES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (697, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ITAJAÍ ', ' ', NULL, ' DRF-ITAJAI', ' DRF-ITAJAI - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ITAJAÍ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (699, NULL, 'HOSPITAL DE CLÍNICAS ', ' ', NULL, ' HC-UFPR', ' HC-UFPR - HOSPITAL DE CLÍNICAS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (700, 5001, 'CENTRO DE INSTRUÇÃO E ADAPTAÇÃO DA AERONÁUTICA', ' ', NULL, ' CIAAR', ' CIAAR - CENTRO DE INSTRUÇÃO E ADAPTAÇÃO DA AERONÁUTICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (704, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO TRIÂNGULO MINEIRO ', ' ', NULL, ' IF TM', ' IF TM - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO TRIÂNGULO MINEIRO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (705, 376, 'FUNDAÇÃO UNIVERSIDADE FEDERAL DO PAMPA', ' ', NULL, ' UNIPAMPA', ' UNIPAMPA - FUNDAÇÃO UNIVERSIDADE FEDERAL DO PAMPA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (707, 10011, 'SECRETARIA DE ESTADO DE FAZENDA DE MINAS GERAIS ', ' ', NULL, ' SEF-MG', ' SEF-MG - SECRETARIA DE ESTADO DE FAZENDA DE MINAS GERAIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (709, NULL, 'JUSTIÇA FEDERAL DE PRIMEIRO GRAU NO RIO GRANDE DO SUL', ' ', NULL, ' JF-RS', ' JF-RS - JUSTIÇA FEDERAL DE PRIMEIRO GRAU NO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (710, NULL, 'MUNICÍPIOS DE LIVRAMENTO, GURJÃO, SUMÉ, CABACEIRAS E UIRAÚNA/PB', ' ', NULL, ' ', '  - MUNICÍPIOS DE LIVRAMENTO, GURJÃO, SUMÉ, CABACEIRAS E UIRAÚNA/PB');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (713, 183, 'GABINETE DA SUPERINTENDÊNCIA', ' ', NULL, ' GABIN09', ' GABIN09 - GABINETE DA SUPERINTENDÊNCIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (715, 183, 'DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA', ' ', NULL, ' DIANA09', ' DIANA09 - DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (717, 183, 'DIVISÃO DE FISCALIZAÇÃO', ' ', NULL, ' DIFIS09', ' DIFIS09 - DIVISÃO DE FISCALIZAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (718, 183, 'DIVISÃO DE GESTÃO DE PESSOAS', ' ', NULL, ' DIGEP09', ' DIGEP09 - DIVISÃO DE GESTÃO DE PESSOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (720, 183, 'DIVISÃO DE ARRECADAÇÃO E COBRANÇA', ' ', NULL, ' DIRAC09', ' DIRAC09 - DIVISÃO DE ARRECADAÇÃO E COBRANÇA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (721, 183, 'DIVISÃO DE TRIBUTAÇÃO', ' ', NULL, ' DISIT09', ' DISIT09 - DIVISÃO DE TRIBUTAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (723, 183, 'DIVISÃO DE INTERAÇÃO COM O CIDADÃO', ' ', NULL, ' DIVIC09', ' DIVIC09 - DIVISÃO DE INTERAÇÃO COM O CIDADÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (724, 183, 'SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES', ' ', NULL, ' SEMAC09', ' SEMAC09 - SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (726, 10016, 'PREFEITURA MUNICIPAL DE SANTOS', ' ', NULL, ' PREF SANTOS', ' PREF SANTOS - PREFEITURA MUNICIPAL DE SANTOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (727, 10016, 'PREFEITURA MUNICIPAL DE ITU', ' ', NULL, ' PMIT', ' PMIT - PREFEITURA MUNICIPAL DE ITU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (728, 345, 'COORDENAÇÃO DA RECEITA DO ESTADO', ' ', NULL, ' CRE-PR', ' CRE-PR - COORDENAÇÃO DA RECEITA DO ESTADO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (729, NULL, 'MINISTÉRIO PÚBLICO DO ESTADO DO PARÁ', ' ', NULL, ' MP-PA', ' MP-PA - MINISTÉRIO PÚBLICO DO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (731, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA CATARINENSE', ' ', NULL, ' IFC - SC', ' IFC - SC - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA CATARINENSE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (732, 152, 'COORDENAÇÃO-GERAL DE GESTÃO DE PESSOAS', ' ', NULL, ' COGEP', ' COGEP - COORDENAÇÃO-GERAL DE GESTÃO DE PESSOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (733, NULL, 'ITAIPU BINACIONAL', ' ', NULL, ' ITAIPU', ' ITAIPU - ITAIPU BINACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (735, 10011, 'PREFEITURA MUNICIPAL DE IPATINGA', ' ', NULL, ' PMIP', ' PMIP - PREFEITURA MUNICIPAL DE IPATINGA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (737, 140, 'CENTRO DE PESQUISA GONÇALO MONIZ', ' ', NULL, ' CPqGM', ' CPqGM - CENTRO DE PESQUISA GONÇALO MONIZ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (739, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA BAHIA', ' ', NULL, ' IFBA', ' IFBA - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (740, 359, 'FUNDAÇÃO CASA DE RUI BARBOSA', ' ', NULL, ' FCRB', ' FCRB - FUNDAÇÃO CASA DE RUI BARBOSA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (741, 376, 'UNIVERSIDADE FEDERAL DO RECÔNCAVO DA BAHIA ', ' ', NULL, ' UFRB', ' UFRB - UNIVERSIDADE FEDERAL DO RECÔNCAVO DA BAHIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (1035, NULL, 'PREFEITURA DE SÃO PAULO', ' ', NULL, ' ', '  - PREFEITURA DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (1037, NULL, 'PREFEITURA DE BELÉM', ' ', NULL, ' PREF BELÉM ', ' PREF BELÉM  - PREFEITURA DE BELÉM');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (2200, 229, 'PROCURADORIA-GERAL DA UNIÃO', ' ', NULL, ' PGJ-PE', ' PGJ-PE - PROCURADORIA-GERAL DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (5001, 5000, 'DEPARTAMENTO DE ENSINO DA AERONÁUTICA ', ' ', NULL, ' DEPENS', ' DEPENS - DEPARTAMENTO DE ENSINO DA AERONÁUTICA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10000, 356, 'MINISTÉRIO DA FAZENDA', '" Esplanada dos Ministérios - Bloco ""P"" - CEP 70048-900"', NULL, ' MF', ' MF - MINISTÉRIO DA FAZENDA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10001, 10000, 'ESCOLA DE ADMINISTRAÇÃO FAZENDÁRIA', ' ', NULL, ' ESAF', ' ESAF - ESCOLA DE ADMINISTRAÇÃO FAZENDÁRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10003, 356, 'MINISTÉRIO DO TRANSPORTE', ' ', NULL, ' MT', ' MT - MINISTÉRIO DO TRANSPORTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10004, NULL, 'SUPREMO TRIBUNAL FEDERAL', ' Praça dos Três Poderes - CEP 70175-900', NULL, ' STF', ' STF - SUPREMO TRIBUNAL FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10005, NULL, 'TRIBUNAL SUPERIOR DO TRABALHO', ' ', NULL, ' TST', ' TST - TRIBUNAL SUPERIOR DO TRABALHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10006, NULL, 'GOVERNO DO DISTRITO FEDERAL', ' ', NULL, ' GDF', ' GDF - GOVERNO DO DISTRITO FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10007, NULL, 'GOVERNO DO ESTADO DA BAHIA', ' ', NULL, ' BA', ' BA - GOVERNO DO ESTADO DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10008, NULL, 'GOVERNO DO ESTADO DA PARAÍBA', ' ', NULL, ' PB', ' PB - GOVERNO DO ESTADO DA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10010, NULL, 'GOVERNO DO ESTADO DE GOIÁS', ' ', NULL, ' GO', ' GO - GOVERNO DO ESTADO DE GOIÁS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10011, NULL, 'GOVERNO DO ESTADO DE MINAS GERAIS', ' ', NULL, ' MG', ' MG - GOVERNO DO ESTADO DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10013, NULL, 'GOVERNO DO ESTADO DE RONDÔNIA', ' ', NULL, ' RO', ' RO - GOVERNO DO ESTADO DE RONDÔNIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10014, NULL, 'GOVERNO DO ESTADO DE ROIRAMA', ' ', NULL, ' RR', ' RR - GOVERNO DO ESTADO DE ROIRAMA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10016, NULL, 'GOVERNO DO ESTADO DE SÃO PAULO', ' ', NULL, ' SP', ' SP - GOVERNO DO ESTADO DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10017, NULL, 'GOVERNO DO ESTADO DO ACRE', ' ', NULL, ' AC', ' AC - GOVERNO DO ESTADO DO ACRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10018, NULL, 'GOVERNO DO ESTADO DO AMAPÁ', ' ', NULL, ' AP', ' AP - GOVERNO DO ESTADO DO AMAPÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10020, NULL, 'GOVERNO DO ESTADO DO AMAZONAS', ' ', NULL, ' AM', ' AM - GOVERNO DO ESTADO DO AMAZONAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10021, NULL, 'GOVERNO DO ESTADO DO CEARÁ', ' ', NULL, ' CE', ' CE - GOVERNO DO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10023, NULL, 'GOVERNO DO ESTADO DO MARANHÃO', ' ', NULL, ' MA', ' MA - GOVERNO DO ESTADO DO MARANHÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10024, NULL, 'GOVERNO DO ESTADO DO MATO GROSSO', ' ', NULL, ' MT', ' MT - GOVERNO DO ESTADO DO MATO GROSSO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10026, NULL, 'GOVERNO DO ESTADO DO PARÁ', ' ', NULL, ' PA', ' PA - GOVERNO DO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10027, NULL, 'GOVERNO DO ESTADO DO PARANÁ', ' ', NULL, ' PR', ' PR - GOVERNO DO ESTADO DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10029, NULL, 'GOVERNO DO ESTADO DO RIO DE JANEIRO', ' ', NULL, ' RJ', ' RJ - GOVERNO DO ESTADO DO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10030, NULL, 'GOVERNO DO ESTADO DO RIO GRANDE DO SUL', ' ', NULL, ' RS', ' RS - GOVERNO DO ESTADO DO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10032, NULL, 'GOVERNO DO ESTADO DO TOCANTINS', ' ', NULL, ' TO', ' TO - GOVERNO DO ESTADO DO TOCANTINS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10033, NULL, 'TRIBUNAL DE CONTAS DA UNIÃO', ' ', NULL, ' TCU', ' TCU - TRIBUNAL DE CONTAS DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10035, 10004, 'SUPERIOR TRIBUNAL DE JUSTIÇA', ' ', NULL, ' STJ', ' STJ - SUPERIOR TRIBUNAL DE JUSTIÇA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10037, 183, 'DIVISÃO DE REPRESSÃO AO CONTRABANDO E DESCAMINHO DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIREP9', ' DIREP9 - DIVISÃO DE REPRESSÃO AO CONTRABANDO E DESCAMINHO DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10039, 183, 'DIVISÃO DE FISCALIZAÇÃO DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIFIS9', ' DIFIS9 - DIVISÃO DE FISCALIZAÇÃO DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10040, 183, 'DIVISÃO DE GESTÃO DE PESSOAS DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIGEP9', ' DIGEP9 - DIVISÃO DE GESTÃO DE PESSOAS DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10042, 183, 'DIVISÃO DE ARRECADAÇÃO E COBRANÇA DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIRAC9', ' DIRAC9 - DIVISÃO DE ARRECADAÇÃO E COBRANÇA DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10043, 183, 'DIVISÃO DE TRIBUTAÇÃO DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DISIT9', ' DISIT9 - DIVISÃO DE TRIBUTAÇÃO DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10045, 183, 'DIVISÃO DE INTERAÇÃO COM O CIDADÃO DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIVIC9', ' DIVIC9 - DIVISÃO DE INTERAÇÃO COM O CIDADÃO DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10047, 10030, 'PREFEITURA MUNICIPAL DE SANTA MARIA', ' Rua Venâncio Aires, 2277 - Centro - CEP 97010-005', NULL, ' PREF STª MARIA', ' PREF STª MARIA - PREFEITURA MUNICIPAL DE SANTA MARIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10048, 10021, 'TRIBUNAL DE CONTAS DO ESTADO DO CEARÁ', ' Rua Sena Madureira, 1047 - Centro - CEP 60055-080', NULL, ' TC-CE', ' TC-CE - TRIBUNAL DE CONTAS DO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (99999, NULL, 'INSTITUIÇÃO PARTICULAR', ' ', NULL, ' INSTITUIÇÃO PRIVADA OU PARTICULAR', 'INSTITUIÇÃO PARTICULAR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (1, 10000, 'GABINETE DO MINISTRO', ' ', NULL, ' GM', ' GM - GABINETE DO MINISTRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (2, 275, 'COORDENAÇÃO-GERAL DE ADMINISTRAÇÃO ADUANEIRA', ' ', NULL, ' COANA', ' COANA - COORDENAÇÃO-GERAL DE ADMINISTRAÇÃO ADUANEIRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (3, 10000, 'SECRETARIA DO TESOURO NACIONAL', '" Esplanada dos Ministérios - Bloco ""P"" - Ed. Anexo - 1º andar - CEP 70048-900"', NULL, ' STN', ' STN - SECRETARIA DO TESOURO NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (8, 10000, 'CONSELHO NACIONAL DE POLÍTICA FAZENDÁRIA', ' ', NULL, ' CONFAZ', ' CONFAZ - CONSELHO NACIONAL DE POLÍTICA FAZENDÁRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (13, 356, 'MINISTÉRIO DO PLANEJAMENTO, ORÇAMENTO E GESTÃO ', '" Esplanada dos Ministérios - Bloco ""K"" - CEP 70040-906 / Esplanada dos Ministérios - Bloco ""C"" - CEP 70048-900"', NULL, ' MPOG', ' MPOG - MINISTÉRIO DO PLANEJAMENTO, ORÇAMENTO E GESTÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (22, 17, 'DEPARTAMENTO DE POLÍCIA RODOVIÁRIA FEDERAL', ' ', NULL, ' DPRF', ' DPRF - DEPARTAMENTO DE POLÍCIA RODOVIÁRIA FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (24, 305, 'SUPERINTENDÊNCIA DA ZONA FRANCA DE MANAUS', 'Av. Ministro Mário Andreazza, 1.424 - Distrito Industrial - CEP 69075-830', NULL, ' SUFRAMA', ' SUFRAMA - SUPERINTENDÊNCIA DA ZONA FRANCA DE MANAUS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (29, 10000, 'SERVIÇO FEDERAL DE PROCESSAMENTO DE DADOS ', ' ', NULL, ' SERPRO', ' SERPRO - SERVIÇO FEDERAL DE PROCESSAMENTO DE DADOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (44, 10001, 'CENTRO REGIONAL DE TREINAMENTO NO CEARÁ', ' ', NULL, ' CENTRESAF-CE', ' CENTRESAF-CE - CENTRO REGIONAL DE TREINAMENTO NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (46, 10001, 'CENTRO REGIONAL DE TREINAMENTO EM MINAS GERAIS', ' ', NULL, ' CENTRESAF-MG', ' CENTRESAF-MG - CENTRO REGIONAL DE TREINAMENTO EM MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (49, 10001, 'CENTRO REGIONAL DE TREINAMENTO NO PARANÁ', ' ', NULL, ' CENTRESAF-PR', ' CENTRESAF-PR - CENTRO REGIONAL DE TREINAMENTO NO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (52, 10001, 'CENTRO REGIONAL DE TREINAMENTO NO RIO GRANDE DO SUL', ' ', NULL, ' CENTRESAF - RS', ' CENTRESAF - RS - CENTRO REGIONAL DE TREINAMENTO NO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (58, 356, 'SECRETARIA ESPECIAL DO CONSELHO DE DESENVOLVIMENTO ECONÔMICO E SOCIAL', ' ', NULL, ' SEDES', ' SEDES - SECRETARIA ESPECIAL DO CONSELHO DE DESENVOLVIMENTO ECONÔMICO E SOCIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (64, 266, 'AGÊNCIA NACIONAL DE TELECOMUNICAÇÕES ', ' ', NULL, ' ANATEL', ' ANATEL - AGÊNCIA NACIONAL DE TELECOMUNICAÇÕES ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10051, 376, 'UNIVERSIDADE FEDERAL DO OESTE DO PARÁ', ' AV. Veras Paz, s/nº - Salé - CEP 68135-110', NULL, ' UFOPA', ' UFOPA - UNIVERSIDADE FEDERAL DO OESTE DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10052, 376, 'UNIVERSIDADE FEDERAL DE ALAGOAS', ' Av. Lourival Melo Mota, s/nº - Cidade Universitária - CEP 57072-900', NULL, ' UFAL', ' UFAL - UNIVERSIDADE FEDERAL DE ALAGOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10055, 376, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO RIO GRANDE DO SUL', ' Rua General Osório, 348 - Centro - CEP 95700-000', NULL, ' IFRS', ' IFRS - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10056, 376, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO ACRE', ' Rua Coronel José Galdino, 495 - Bosque - CEP 69909-760', NULL, ' IFAC', ' IFAC - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO ACRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10058, NULL, 'CESEC - POETA MURILO MENDES', ' Av. Assis Chateaubriand, 127 - Floresta - CEP 30150-100', NULL, ' CESEC', ' CESEC - CESEC - POETA MURILO MENDES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10059, 376, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO ACRE', ' AV. Antonio da Rocha Viana, 1812 - Vila Ivonete - CEP 69914-610', NULL, ' IF AC', ' IF AC - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO ACRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10061, 10000, 'PROCURADORIA DA FAZENDA NACIONAL NA PARAÍBA', 'Av. Epitácio Pesssoa, 1705 - 1º andar - Bairro dos Estados - CEP 58030-900', NULL, ' PFN-PB', ' PFN-PB - PROCURADORIA DA FAZENDA NACIONAL NA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10062, 10002, 'INSTITUTO NACIONAL DE TECNOLOGIA', ' Av. Venezuela, 82 - Praça Mauá - CEP 20081-312', NULL, ' INT', ' INT - INSTITUTO NACIONAL DE TECNOLOGIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10063, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DA PARAÍBA', ' ', NULL, ' TCE - PB', ' TCE - PB - TRIBUNAL DE CONTAS DO ESTADO DA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10064, 85, 'ALFÂNDEGA NO PORTO DE MANAUS', ' Rua Marquês de Santa Cruz, s/nº - Prédio da Alfândega - Centro - CEP 69005-50', NULL, ' ALF/MNS', ' ALF/MNS - ALFÂNDEGA NO PORTO DE MANAUS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10066, 356, 'SECRETARIA DE POLÍTICAS PARA AS MULHERES', ' ', NULL, ' SPM', ' SPM - SECRETARIA DE POLÍTICAS PARA AS MULHERES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10067, 10068, 'PROCURADORIA REGIONAL DA REPÚBLICA - 3ª REGIÃO', ' Rua da Consolação, 1875 - 3º,4º e 5º andares - Cerqueira César - CEP 01301-100', NULL, ' PRR-3ª', ' PRR-3ª - PROCURADORIA REGIONAL DA REPÚBLICA - 3ª REGIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10068, 356, 'ADVOCACIA-GERAL DA UNIÃO', ' SAS Q. 03 - Lote 5/6, Ed. Multi Brasil Corporate - CEP 70070-030', NULL, ' AGU', ' AGU - ADVOCACIA-GERAL DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10070, 166, 'CONTROLADORIA REGIONAL DA UNIAO NO ESTADO DO PARANÁ', ' Rua Marechal Deodoro, 555, Ed. Min. da Fazenda, 5º andar - CEP 80020-911', NULL, ' CGU-PR', ' CGU-PR - CONTROLADORIA REGIONAL DA UNIAO NO ESTADO DO PARANÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10071, NULL, 'CÂMARA DOS DEPUTADOS', ' Palácio do Congresso Nacional - Praça dos Três Poderes - CEP 70160-900', NULL, ' CD', ' CD - CÂMARA DOS DEPUTADOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10072, 85, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM MANAUS', ' Rua Marechal Deodoro, 27 - Centro - CEP:69005-000', NULL, ' DRF/MNS', ' DRF/MNS - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM MANAUS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10074, 10001, 'DIRETORIA DE EDUCAÇÃO', ' Rodovia DF 001 - Km 27,4 - SHIS - LAGO SUL - CEP 71686-900', NULL, ' DIRED', ' DIRED - DIRETORIA DE EDUCAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10075, 152, 'COORDENAÇÃO GERAL DE RECURSOS LOGÍSTICOS', ' ', NULL, ' COGRL', ' COGRL - COORDENAÇÃO GERAL DE RECURSOS LOGÍSTICOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10077, 356, 'MINISTÉRIO DA PREVIDÊNCIA E ASSISTÊNCIA SOCIAL', ' ', NULL, ' MPAS', ' MPAS - MINISTÉRIO DA PREVIDÊNCIA E ASSISTÊNCIA SOCIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10078, NULL, 'FUNDAÇÃO LEGIÃO BRASILEIRA DE ASSISTÊNCIA', '', NULL, 'LBA', 'LBA - FUNDAÇÃO LEGIÃO BRASILEIRA DE ASSISTÊNCIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10079, 376, 'UNIVERSIDADE FEDERAL DA BAHIA', ' ', NULL, ' UFBA', ' UFBA - UNIVERSIDADE FEDERAL DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10082, 356, 'COMISSÃO DE ÉTICA PÚBLICA DA PRESIDÊNCIA DA REPÚBLICA', ' ', NULL, ' CEP-PR', ' CEP-PR - COMISSÃO DE ÉTICA PÚBLICA DA PRESIDÊNCIA DA REPÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10083, 10000, 'COMISSÃO DE GESTÃO FAZENDÁRIA', ' ', NULL, ' COGEF', ' COGEF - COMISSÃO DE GESTÃO FAZENDÁRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10084, 10087, 'INSTITUTO DE PESQUISA ECONÔMICA APLICADA', ' ', NULL, ' IPEA', ' IPEA - INSTITUTO DE PESQUISA ECONÔMICA APLICADA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10086, 461, 'INSTITUTO DE AERONÁUTICA E ESPACO', ' ', NULL, ' IAE', ' IAE - INSTITUTO DE AERONÁUTICA E ESPACO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10088, 10004, 'TRIBUNAL REGIONAL FEDERAL - 5ª REGIAO', ' ', NULL, ' TRF', ' TRF - TRIBUNAL REGIONAL FEDERAL - 5ª REGIAO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10089, NULL, 'JUSTIÇA FEDERAL DE 1º GRAU NO CEARÁ', ' ', NULL, ' JF-CE', ' JF-CE - JUSTIÇA FEDERAL DE 1º GRAU NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10090, 227, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM VARGINHA', ' ', NULL, ' DRF/VAR', ' DRF/VAR - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM VARGINHA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10091, 356, 'SECRETARIA DE COMUNICAÇÃO SOCIAL DA PRESIDÊNCIA DA REPÚBLICA', ' ', NULL, ' SECOM/PR', ' SECOM/PR - SECRETARIA DE COMUNICAÇÃO SOCIAL DA PRESIDÊNCIA DA REPÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10092, 376, 'UNIVERSIDADE FEDERAL DO CEARÁ', ' ', NULL, ' UFC', ' UFC - UNIVERSIDADE FEDERAL DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (65, 10010, 'GERÊNCIA EXECUTIVA DA ESCOLA DE GOVERNO - AGÊNCIA DE ADMINISTRAÇÃO DO ESTADO DE GOIÁS', ' ', NULL, ' ESGOV-GO', ' ESGOV-GO - GERÊNCIA EXECUTIVA DA ESCOLA DE GOVERNO - AGÊNCIA DE ADMINISTRAÇÃO DO ESTADO DE GOIÁS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (70, 275, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO', ' ', NULL, ' DRFJ', ' DRFJ - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (71, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 8ª REGIÃO FISCAL ', ' ', NULL, ' SRRF08', ' SRRF08 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 8ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (77, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DO RIO GRANDE DO SUL ', ' ', NULL, ' CGU-RS', ' CGU-RS - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DO RIO GRANDE DO SUL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (82, 13, 'INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA', ' ', NULL, ' IBGE', ' IBGE - INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (85, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 2ª REGIÃO FISCAL', ' ', NULL, ' SRRF02', ' SRRF02 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 2ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (88, 376, 'UNIVERSIDADE FEDERAL DO ESTADO DO PARÁ', ' ', NULL, ' UEPA', ' UEPA - UNIVERSIDADE FEDERAL DO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (98, 366, 'DELEGACIA DA RECEITA FEDERAL 1ª REGIÃO FISCAL', ' ', NULL, ' DRF1', ' DRF1 - DELEGACIA DA RECEITA FEDERAL 1ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (101, 10013, 'SECRETARIA DE FINANÇAS DO ESTADO DE RONDÔNIA ', ' ', NULL, ' SEFIN-RO', ' SEFIN-RO - SECRETARIA DE FINANÇAS DO ESTADO DE RONDÔNIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (105, 10001, 'CENTRESAF/BA - CURSO ABERTO', ' ', NULL, ' CENTRESAF-BA', ' CENTRESAF-BA - CENTRESAF/BA - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (108, 10001, 'CENTRESAF/PA - CURSO ABERTO', ' ', NULL, ' CENTRESAF-PA', ' CENTRESAF-PA - CENTRESAF/PA - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (110, 10001, 'CENTRESAF/PR - CURSO ABERTO ', ' ', NULL, ' CENTRESAF-PR', ' CENTRESAF-PR - CENTRESAF/PR - CURSO ABERTO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (111, 10001, 'CENTRESAF/SP - CURSO ABERTO', ' ', NULL, ' CENTRESAF-SP', ' CENTRESAF-SP - CENTRESAF/SP - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (112, 10001, 'CENTRESAF/RJ - CURSO ABERTO', ' ', NULL, ' CENTRESAF-RJ', ' CENTRESAF-RJ - CENTRESAF/RJ - CURSO ABERTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (115, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 4ª REGIÃO FISCAL', ' ', NULL, ' SRRF04', ' SRRF04 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 4ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (119, 172, 'TRIBUNAL REGIONAL ELEITORAL DO RIO GRANDE DO NORTE ', ' ', NULL, ' TRE-RN', ' TRE-RN - TRIBUNAL REGIONAL ELEITORAL DO RIO GRANDE DO NORTE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (124, 10019, 'SECRETARIA DE FAZENDA DE PERNAMBUCO ', ' ', NULL, ' SEFAZ-PE', ' SEFAZ-PE - SECRETARIA DE FAZENDA DE PERNAMBUCO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (126, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DA PARAÍBA', ' ', NULL, ' TCE-PB', ' TCE-PB - TRIBUNAL DE CONTAS DO ESTADO DA PARAÍBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (130, 5, 'PROCURADORIA REGIONAL DA FAZENDA NACIONAL EM PERNAMBUCO ', '', NULL, ' PRFN-PE', ' PRFN-PE - PROCURADORIA REGIONAL DA FAZENDA NACIONAL EM PERNAMBUCO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (132, 10019, 'PROCURADORIA DA REPÚBLICA DO ESTADO DE PERNAMBUCO', ' ', NULL, ' PROC-PE', ' PROC-PE - PROCURADORIA DA REPÚBLICA DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (140, 79, 'FUNDAÇÃO OSVALDO CRUZ', ' ', NULL, ' FIOCRUZ', ' FIOCRUZ - FUNDAÇÃO OSVALDO CRUZ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (141, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO ESPÍRITO SANTO', ' ', NULL, ' GRA-ES', ' GRA-ES - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO ESPÍRITO SANTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (146, NULL, 'PREFEITURA MUNICIPAL DO RIO DE JANEIRO', ' ', NULL, ' PREF-RJ', ' PREF-RJ - PREFEITURA MUNICIPAL DO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (152, 385, 'SUBSECRETARIA DE PLANEJAMENTO, ORÇAMENTO E ADMINISTRAÇÃO ', ' ', NULL, ' SPOA', ' SPOA - SUBSECRETARIA DE PLANEJAMENTO, ORÇAMENTO E ADMINISTRAÇÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (154, 10029, 'SECRETARIA DE FAZENDA DO ESTADO DO RIO DE JANEIRO ', ' ', NULL, ' SEFAZ-RJ', ' SEFAZ-RJ - SECRETARIA DE FAZENDA DO ESTADO DO RIO DE JANEIRO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (157, NULL, 'TRIBUNAL DE CONTAS DO ESTADO DO RIO DE JANEIRO - TCE/RJ', ' ', NULL, ' TCE-RJ', ' TCE-RJ - TRIBUNAL DE CONTAS DO ESTADO DO RIO DE JANEIRO - TCE/RJ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (161, 10000, 'SUPERINTENDÊNCIA DE SEGUROS PRIVADOS', ' ', NULL, ' SUSEP', ' SUSEP - SUPERINTENDÊNCIA DE SEGUROS PRIVADOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (165, 5, 'PROCURADORIA-REGIONAL DA FAZENDA NACIONAL EM SÃO PAULO', 'Av. Alameda Santos, 647, 15º andar - CERQUEIRA CÉSAR - CEP 01419-001', NULL, ' PRFN-SP', ' PRFN-SP - PROCURADORIA-REGIONAL DA FAZENDA NACIONAL EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (168, 10032, 'SECRETARIA MUNICIPAL DE PLANEJAMENTO E ADMINISTRAÇÃO DE PALMAS', ' ', NULL, ' SECM PALMAS ', ' SECM PALMAS  - SECRETARIA MUNICIPAL DE PLANEJAMENTO E ADMINISTRAÇÃO DE PALMAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (173, 227, 'GRUPO DE TRABALHO QUALIDADE CONTINUADA', ' ', NULL, ' GTQC6', ' GTQC6 - GRUPO DE TRABALHO QUALIDADE CONTINUADA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (176, NULL, 'SINDICATO NACIONAL DOS AUDITORES-FISCAIS DA SRF - DELEGACIA SINDICAL EM RECIFE ', ' ', NULL, ' SIND AFRF -PE', ' SIND AFRF -PE - SINDICATO NACIONAL DOS AUDITORES-FISCAIS DA SRF - DELEGACIA SINDICAL EM RECIFE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (179, 275, 'COORDENAÇÃO-GERAL DE TECNOLOGIA E SEGURANÇA DA INFORMAÇÃO', ' ', NULL, ' COTEC', ' COTEC - COORDENAÇÃO-GERAL DE TECNOLOGIA E SEGURANÇA DA INFORMAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (183, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 9ª REGIÃO FISCAL', ' ', NULL, ' SRRF09', ' SRRF09 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (187, NULL, 'PREFEITURA MUNICIPAL DE BOA VISTA ', ' ', NULL, ' PREF BOA VISTA', ' PREF BOA VISTA - PREFEITURA MUNICIPAL DE BOA VISTA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (189, NULL, 'PRICEWATERHOUSECOOPERS S/C LTDA', 'Av. Francisco Matarazzo, 1400, Torre Torino - CEP 05001-903', NULL, ' PWC', ' PWC - PRICEWATERHOUSECOOPERS S/C LTDA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (197, 275, 'COORDENAÇÃO-GERAL DE PESQUISA E INVESTIGAÇÃO ', ' ', NULL, ' COPEI', ' COPEI - COORDENAÇÃO-GERAL DE PESQUISA E INVESTIGAÇÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (200, 192, 'JARDIM BOTÂNICO DO RIO DE JANEIRO', ' ', NULL, ' JBOT-RJ', ' JBOT-RJ - JARDIM BOTÂNICO DO RIO DE JANEIRO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (203, NULL, 'PREFEITURA MUNICIPAL DE JOINVILLE', ' ', NULL, ' PREF JOINVILLE', ' PREF JOINVILLE - PREFEITURA MUNICIPAL DE JOINVILLE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (205, NULL, 'PREFEITURA MUNICIPAL DE PINHAIS', ' ', NULL, ' PREF PINHAIS-PR', ' PREF PINHAIS-PR - PREFEITURA MUNICIPAL DE PINHAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (208, 356, 'AGÊNCIA BRASILEIRA DE INTELIGÊNCIA ', ' ', NULL, ' ABIN', ' ABIN - AGÊNCIA BRASILEIRA DE INTELIGÊNCIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (210, 10021, 'SECRETARIA DE FAZENDA DO ESTADO DO CEARÁ', ' ', NULL, ' SEFAZ-CE', ' SEFAZ-CE - SECRETARIA DE FAZENDA DO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (211, 213, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM FORTALEZA', 'Rua Barão de Aracati, 909 - 5º andar - Aldeota - CEP 60115-901', NULL, ' DRJ/FOR', ' DRJ/FOR - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM FORTALEZA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (216, NULL, 'UNIÃO NACIONAL DOS ANALISTAS E TÉCNICOS DE FINANÇAS E CONTROLE NO CEARÁ', ' ', NULL, ' UNACON-CE', ' UNACON-CE - UNIÃO NACIONAL DOS ANALISTAS E TÉCNICOS DE FINANÇAS E CONTROLE NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (219, NULL, 'SECRETARIA MUNICIPAL DE FINANÇAS DE TERESINA', ' ', NULL, ' SEMF-PI', ' SEMF-PI - SECRETARIA MUNICIPAL DE FINANÇAS DE TERESINA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (221, 213, 'ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 3ª REGIÃO FISCAL', ' ', NULL, ' ESCOR3', ' ESCOR3 - ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 3ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (224, 10001, 'CENTRO ESTRATÉGICO DE FORMAÇÃO E EDUCAÇÃO PERMANENTE', ' ', NULL, ' CEFOR', ' CEFOR - CENTRO ESTRATÉGICO DE FORMAÇÃO E EDUCAÇÃO PERMANENTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (227, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 6ª REGIÃO FISCAL', ' ', NULL, ' SRRF06', ' SRRF06 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 6ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (231, 258, 'ALFÂNDEGA DO PORTO DE SALVADOR', ' ', NULL, ' ALF/SDR', ' ALF/SDR - ALFÂNDEGA DO PORTO DE SALVADOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (392, 13, 'SECRETARIA DE PLANEJAMENTO E INVESTIMENTOS ESTRATÉGICOS', ' ', NULL, ' SPI', ' SPI - SECRETARIA DE PLANEJAMENTO E INVESTIMENTOS ESTRATÉGICOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (233, 258, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ARACAJU', ' Av. Paulo Henrique Machado Pimentel, 140 - Distrito Industrial - Inácio Barbosa - CEP 49040-740', NULL, ' DRF/AJU', ' DRF/AJU - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ARACAJU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (237, 258, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SALVADOR', 'Rua Alceu Amoroso Lima, 862, 9º andar - CAMINHO DAS ÁRVORES - CEP 41820-770', NULL, ' DRF-SALVADOR', ' DRF-SALVADOR - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SALVADOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (240, 258, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM SALVADOR', 'Av. Jequitaia, s/nº - Ed. Min. da Fazenda 5º andar - Sala 500 - Comércio - CEP 40015-902', NULL, ' DRJ/SDR', ' DRJ/SDR - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM SALVADOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (249, NULL, 'PREFEITURA MUNICIPAL DE LAGARTO', ' ', NULL, ' PREFLagarto-SE', ' PREFLagarto-SE - PREFEITURA MUNICIPAL DE LAGARTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (251, NULL, 'PREFEITURA MUNICIPAL DE NOSSA SENHORA DAS DORES', ' ', NULL, ' PREFN.Srª Dores-SE', ' PREFN.Srª Dores-SE - PREFEITURA MUNICIPAL DE NOSSA SENHORA DAS DORES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (254, NULL, 'PREFEITURA MUNICIPAL DE SAÚDE', ' ', NULL, ' PREFMS-SE', ' PREFMS-SE - PREFEITURA MUNICIPAL DE SAÚDE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (257, 10007, 'SECRETARIA DE FAZENDA DO ESTADO DA BAHIA ', ' ', NULL, ' SEFAZ-BA', ' SEFAZ-BA - SECRETARIA DE FAZENDA DO ESTADO DA BAHIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (258, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 5ª REGIÃO FISCAL', ' ', NULL, ' SRRF05', ' SRRF05 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 5ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (262, 10003, 'DEPARTAMENTO NACIONAL DE INFRA-ESTRUTURA DE TRANSPORTES', ' ', NULL, ' DENIT', ' DENIT - DEPARTAMENTO NACIONAL DE INFRA-ESTRUTURA DE TRANSPORTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (264, 66, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM PORTO ALEGRE', 'Av. Loureiro da Silva, 445, 3º andar Sala 307 - Centro - CEP 90013-900', NULL, ' DRJ/POA ', ' DRJ/POA  - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM PORTO ALEGRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (271, 10006, 'TRIBUNAL DE CONTAS DO DISTRITO FEDERAL', ' ', NULL, ' TCDF', ' TCDF - TRIBUNAL DE CONTAS DO DISTRITO FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (274, 10018, 'SECRETARIA DA FAZENDA DO AMAPÁ', ' ', NULL, ' SEFAZ-AP', ' SEFAZ-AP - SECRETARIA DA FAZENDA DO AMAPÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (276, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DE PERNAMBUCO', ' ', NULL, ' CGU-PE', ' CGU-PE - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (280, NULL, 'PREFEITURA DE CABO DE SANTO AGOSTINHO', ' ', NULL, ' PREF STºAGOSTINHO', ' PREF STºAGOSTINHO - PREFEITURA DE CABO DE SANTO AGOSTINHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (282, 166, 'CONTROLADORIA-GERAL DA UNIÃO NO ESTADO DO CEARÁ', ' ', NULL, ' CGU-CE', ' CGU-CE - CONTROLADORIA-GERAL DA UNIÃO NO ESTADO DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (285, 10030, 'SECRETARIA DE JUSTIÇA E SEGURANÇA DO ESTADO DO RIO GRANDE DO SUL ', ' ', NULL, ' SECJS-RS', ' SECJS-RS - SECRETARIA DE JUSTIÇA E SEGURANÇA DO ESTADO DO RIO GRANDE DO SUL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (288, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DE MINAS GERAIS', ' ', NULL, ' CGU-MG', ' CGU-MG - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (291, 5, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE MINAS GERAIS ', 'Av. Afonso Pena, 1.500, 6º andar -  CEP 30130-005', NULL, ' PRFN-MG', ' PRFN-MG - PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE MINAS GERAIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (296, 10034, 'INSTITUTO MUNICIPAL DE ADMINISTRAÇÃO PÚBLICA', ' ', NULL, ' IMAP', ' IMAP - INSTITUTO MUNICIPAL DE ADMINISTRAÇÃO PÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (302, 10001, 'DIRETORIA DE ATENDIMENTO E COORDENAÇÃO DE PROGRAMAS', ' ', NULL, ' DIRAT', ' DIRAT - DIRETORIA DE ATENDIMENTO E COORDENAÇÃO DE PROGRAMAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (304, 376, 'FUNDAÇÃO COORDENAÇÃO DE PESSOAL DE NÍVEL SUPERIOR', ' ', NULL, ' CAPES', ' CAPES - FUNDAÇÃO COORDENAÇÃO DE PESSOAL DE NÍVEL SUPERIOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (306, 66, 'ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 10ª REGIÃO FISCAL', ' ', NULL, ' ESCOR10', ' ESCOR10 - ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 10ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (311, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL - 9ª REGIÃO FISCAL', ' ', NULL, ' DRF9', ' DRF9 - DELEGACIA DA RECEITA FEDERAL DO BRASIL - 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (313, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL FOZ DO IGUAÇU ', 'Av. Paraná, 1.227 - Jd. Polo - Centro - CEP 85863-720', NULL, ' DRF/FOZ', ' DRF/FOZ - DELEGACIA DA RECEITA FEDERAL DO BRASIL FOZ DO IGUAÇU ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (318, 183, 'DELEGACIA DA RECEITA FEDERAL EM FLORIANÓPOLIS', ' ', NULL, ' DRF/FNS', ' DRF/FNS - DELEGACIA DA RECEITA FEDERAL EM FLORIANÓPOLIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (321, 183, 'INSPETORIA DA RECEITA FEDERAL DE CURITIBA ', ' ', NULL, ' IRF/CTA', ' IRF/CTA - INSPETORIA DA RECEITA FEDERAL DE CURITIBA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (323, 183, 'ESCRITÓRIO DA CORREGEDORIA-GERAL NA 9ª REGIÃO FISCAL', ' ', NULL, ' ESCOR9', ' ESCOR9 - ESCRITÓRIO DA CORREGEDORIA-GERAL NA 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (326, 71, 'DELEGACIA REGIONAL DE JULGAMENTO', ' ', NULL, ' DRJ8', ' DRJ8 - DELEGACIA REGIONAL DE JULGAMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (327, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SÃO SEBASTIÃO ', ' ', NULL, ' DRF SÃO SEBASTIAO', ' DRF SÃO SEBASTIAO - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SÃO SEBASTIÃO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (332, 183, 'DELEGACIA DA RECEITA FEDERAL EM CURITIBA ', 'Rua João Negrão, 21, 4º andar - Centro - CEP 80010-200', NULL, ' DRF/CTA', ' DRF/CTA - DELEGACIA DA RECEITA FEDERAL EM CURITIBA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (335, 71, 'DELEGACIA DE ADMINISTRAÇÃO TRIBUTÁRIA EM SÃO PAULO ', ' ', NULL, ' DERAT', ' DERAT - DELEGACIA DE ADMINISTRAÇÃO TRIBUTÁRIA EM SÃO PAULO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (338, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM LIMEIRA', 'Rua Pedro Zaccaria, 444 - Jd. Nova Itália - CEP 13484-901', NULL, ' DRF/LIM', ' DRF/LIM - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM LIMEIRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (342, 143, 'CENTRAIS DE ABASTECIMENTO DE MINAS GERAIS S/A ', ' ', NULL, ' CEASA-MG', ' CEASA-MG - CENTRAIS DE ABASTECIMENTO DE MINAS GERAIS S/A ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (344, 80, 'DIRETORIA DA RECEITA PREVIDENCIÁRIA', ' ', NULL, ' DRP - INSS', ' DRP - INSS - DIRETORIA DA RECEITA PREVIDENCIÁRIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (347, 172, 'TRIBUNAL DE JUSTIÇA DO ESTADO DE PERNAMBUCO ', ' ', NULL, ' TJ-PE', ' TJ-PE - TRIBUNAL DE JUSTIÇA DO ESTADO DE PERNAMBUCO ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (351, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ARARAQUARA', 'Av. Rodrigo Fernando Grillo, 2775 - Jardim das Flores - CEP: 14801-534', NULL, ' DRF/AQA', ' DRF/AQA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM ARARAQUARA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (355, 275, 'COORDENAÇÃO-GERAL DE PLANEJAMENTO ORGANIZAÇÃO E AVALIAÇÃO INSTITUCIONAL', ' ', NULL, ' COPAV', ' COPAV - COORDENAÇÃO-GERAL DE PLANEJAMENTO ORGANIZAÇÃO E AVALIAÇÃO INSTITUCIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (360, 376, 'COORDENAÇÃO-GERAL DE GESTÃO DE PESSOAS ', ' ', NULL, ' CGGP-MEC', ' CGGP-MEC - COORDENAÇÃO-GERAL DE GESTÃO DE PESSOAS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (365, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM TAUBATÉ', 'Rua Marechal Arthur da Costa e Silva, 730 - CENTRO - CEP 12010-490', NULL, ' DRF/TAU', ' DRF/TAU - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM TAUBATÉ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (367, 166, 'CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DE MATO GROSSO', ' ', NULL, ' CGU-MT', ' CGU-MT - CONTROLADORIA-REGIONAL DA UNIÃO NO ESTADO DE MATO GROSSO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (372, 166, 'CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DO PARÁ', ' ', NULL, ' CGU-PA', ' CGU-PA - CONTROLADORIA REGIONAL DA UNIÃO NO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (376, 356, 'MINISTÉRIO DA EDUCAÇÃO', '" Esplanada dos Ministérios - Bloco ""L"" - Ed. Sede e Anexos - CEP 70047-900"', NULL, ' MEC', ' MEC - MINISTÉRIO DA EDUCAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (380, 10015, 'PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE SANTA CATARINA', ' ', NULL, ' PFN-SC', ' PFN-SC - PROCURADORIA DA FAZENDA NACIONAL NO ESTADO DE SANTA CATARINA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (383, 10001, 'GERÊNCIA DO PROGRAMA DE EDUCAÇÃO FISCAL', ' ', NULL, ' GEREF', ' GEREF - GERÊNCIA DO PROGRAMA DE EDUCAÇÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (386, 376, 'SUBSECRETARIA DE ASSUNTOS ADMINISTRATIVOS', ' ', NULL, ' SAA-MEC', ' SAA-MEC - SUBSECRETARIA DE ASSUNTOS ADMINISTRATIVOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (396, NULL, 'MINISTÉRIO PÚBLICO FEDERAL ', ' ', NULL, ' MPF', ' MPF - MINISTÉRIO PÚBLICO FEDERAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (397, 229, 'PROCURADORIA DA REPÚBLICA NO DISTRITO FEDERAL', ' ', NULL, ' PROC-DF', ' PROC-DF - PROCURADORIA DA REPÚBLICA NO DISTRITO FEDERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (400, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CAXIAS DO SUL', 'Rua Desembargador Armando Azambuja, 150 - Rio Branco - CEP 95010-902', NULL, ' DRF/CXL', ' DRF/CXL - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CAXIAS DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (403, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTANA DO LIVRAMENTO', ' ', NULL, ' DRF-SANT LIVRAMENTO', ' DRF-SANT LIVRAMENTO - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTANA DO LIVRAMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (406, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTA CRUZ DO SUL', 'Rua Felipe Jacobus Filho, 08 - Centro - CEP 96810-422', NULL, ' DRF/SCS', ' DRF/SCS - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SANTA CRUZ DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (410, 66, 'ALFÂNDEGA DO AEROPORTO INTERNACIONAL SALGADO FILHO', ' ', NULL, ' ALF/POA', ' ALF/POA - ALFÂNDEGA DO AEROPORTO INTERNACIONAL SALGADO FILHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (411, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PORTO ALEGRE', 'Av. Loureiro da Silva, 445, 2º andar Sala 208 - Centro - CEP 90013-900', NULL, ' DRF/POA', ' DRF/POA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PORTO ALEGRE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (417, NULL, 'ASSOCIACAO NACIONAL DOS SERVIDORES DA CARREIRA DE ORÇAMENTO', ' ', NULL, ' ASSECOR', ' ASSECOR - ASSOCIACAO NACIONAL DOS SERVIDORES DA CARREIRA DE ORÇAMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (421, 85, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM BELÉM', 'Rua Gaspar Viana, 485, 16º andar - Comércio - CEP 66010-903', NULL, ' DRJ/BEL ', ' DRJ/BEL  - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM BELÉM');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (425, NULL, 'SINDICATO DOS TRABALHADORES DO MINISTÉRIO DA FAZENDA NO PARÁ ', ' ', NULL, ' SINDFAZ-PA', ' SINDFAZ-PA - SINDICATO DOS TRABALHADORES DO MINISTÉRIO DA FAZENDA NO PARÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (430, 381, 'COMPANHIA BRASILEIRA DE TRENS URBANOS ', ' ', NULL, ' CBTU', ' CBTU - COMPANHIA BRASILEIRA DE TRENS URBANOS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (432, 79, 'COORDENAÇÃO REGIONAL DA FUNDAÇÃO NACIONAL DE SAÚDE NO AMAPÁ', ' ', NULL, ' FUNASA-AP', ' FUNASA-AP - COORDENAÇÃO REGIONAL DA FUNDAÇÃO NACIONAL DE SAÚDE NO AMAPÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (435, 359, 'INSTITUTO DO PATRIMÔNIO HISTÓRICO E ARTÍSTICO NACIONAL', ' ', NULL, ' IPHAN', ' IPHAN - INSTITUTO DO PATRIMÔNIO HISTÓRICO E ARTÍSTICO NACIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (438, 172, 'TRIBUNAL REGIONAL ELEITORAL DO ESTADO DO TOCANTINS', ' ', NULL, ' TRE-TO', ' TRE-TO - TRIBUNAL REGIONAL ELEITORAL DO ESTADO DO TOCANTINS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (442, 461, 'CENTRO TÉCNICO AEROESPACIAL', ' ', NULL, ' CTA', ' CTA - CENTRO TÉCNICO AEROESPACIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (448, 10009, 'SECRETARIA EXECUTIVA DE PLANEJAMENTO E ORÇAMENTO', ' ', NULL, ' SEPLAN - AL', ' SEPLAN - AL - SECRETARIA EXECUTIVA DE PLANEJAMENTO E ORÇAMENTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (451, 376, 'UNIVERSIDADE FEDERAL DE SÃO PAULO', ' ', NULL, ' UNIFESP', ' UNIFESP - UNIVERSIDADE FEDERAL DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (452, NULL, 'CONSELHO REGIONAL DE MEDICINA VETERINÁRIA DO ESTADO DE PERNAMBUCO', ' ', NULL, ' CRMV-PE', ' CRMV-PE - CONSELHO REGIONAL DE MEDICINA VETERINÁRIA DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (456, 376, 'ESCOLA AGROTÉCNICA FEDERAL DE IQUATU', ' ', NULL, ' EAFI-CE', ' EAFI-CE - ESCOLA AGROTÉCNICA FEDERAL DE IQUATU');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (461, 356, 'MINISTÉRIO DA DEFESA', '" Esplanada dos Ministérios - Bloco ""Q"" - CEP 70049-900"', NULL, ' MD', ' MD - MINISTÉRIO DA DEFESA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (463, 356, 'SECRETARIA ESPECIAL DE AQÜICULTURA E PESCA DA PRESIDÊNCIA DA REPÚBLICA ', ' ', NULL, ' SEAP-PR', ' SEAP-PR - SECRETARIA ESPECIAL DE AQÜICULTURA E PESCA DA PRESIDÊNCIA DA REPÚBLICA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (468, 305, 'INSTITUTO NACIONAL DE METROLOGIA, NORMALIZAÇÃO E QUALIDADE INDUSTRIAL', ' ', NULL, ' INMETRO', ' INMETRO - INSTITUTO NACIONAL DE METROLOGIA, NORMALIZAÇÃO E QUALIDADE INDUSTRIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (472, 71, 'ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 8ª REGIÃO FISCAL ', ' ', NULL, ' ESCOR8', ' ESCOR8 - ESCRITÓRIO DA CORREGEDORIA DA RECEITA FEDERAL NA 8ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (476, 275, 'COORDENAÇÃO GERAL DE GESTÃO DE PESSOAS ', ' ', NULL, ' COGEP-SRF', ' COGEP-SRF - COORDENAÇÃO GERAL DE GESTÃO DE PESSOAS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (479, NULL, 'ESCOLA NACIONAL DE FORMACAO E APERFEICOAMENTO DE MAGISTRADO DO TRABALHO', ' ', NULL, ' ENEMAT', ' ENEMAT - ESCOLA NACIONAL DE FORMACAO E APERFEICOAMENTO DE MAGISTRADO DO TRABALHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (482, 172, 'TRIBUNAL REGIONAL ELEITORAL DE MINAS GERAIS', ' ', NULL, ' TRE-MG', ' TRE-MG - TRIBUNAL REGIONAL ELEITORAL DE MINAS GERAIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (484, 275, 'DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM SANTA MARIA ', '', NULL, ' DRJ/SANTA MARIA ', ' DRJ/SANTA MARIA  - DELEGACIA DA RECEITA FEDERAL DE JULGAMENTO EM SANTA MARIA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (489, 80, 'GERÊNCIA EXECUTIVA OSASCO', ' Praça das Monções, 101 - 2º andar - Jd. Piratininga - CEP 06233-902', NULL, ' GEX-OSASCO', ' GEX-OSASCO - GERÊNCIA EXECUTIVA OSASCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (493, NULL, 'INTERNATIONALE WEITERBILDUNG UND ENTWICKLUNG GGMBH', ' ', NULL, ' INWENT', ' INWENT - INTERNATIONALE WEITERBILDUNG UND ENTWICKLUNG GGMBH');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (496, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM GUARULHOS', 'Av. Presidente Castelo Branco, 1253 - Vila Augusta - CEP 07040-030', NULL, ' DRF/GUA', ' DRF/GUA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM GUARULHOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (503, 461, 'INSTITUTO DE FOMENTO E COORDENAÇÃO INDUSTRIAL', ' ', NULL, ' IFI', ' IFI - INSTITUTO DE FOMENTO E COORDENAÇÃO INDUSTRIAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (507, 10003, '.AGÊNCIA NACIONAL DE TRANSPORTES TERRESTRES', ' ', NULL, ' ANTT', ' ANTT - .AGÊNCIA NACIONAL DE TRANSPORTES TERRESTRES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (510, NULL, 'PREFEITURA MUNICIPAL DE SOBRAL', ' ', NULL, ' PREF SOBRAL', ' PREF SOBRAL - PREFEITURA MUNICIPAL DE SOBRAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (511, 66, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PASSO FUNDO', 'Rua Paissandu, 753 - Centro - CEP 99010-100', NULL, ' DRF/PFO', ' DRF/PFO - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM PASSO FUNDO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (516, 275, 'COORDENAÇÃO-GERAL DE CONTENCIOSO ADMINISTRATIVO E JUDICIÁRIO', ' ', NULL, ' COCAJ', ' COCAJ - COORDENAÇÃO-GERAL DE CONTENCIOSO ADMINISTRATIVO E JUDICIÁRIO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (519, NULL, 'SECRETARIA DA SAÚDE E AÇÃO SOCIAL - PREFEITURA MUNICIPAL DE SOBRAL', ' ', NULL, ' SSAS/PMS-CE', ' SSAS/PMS-CE - SECRETARIA DA SAÚDE E AÇÃO SOCIAL - PREFEITURA MUNICIPAL DE SOBRAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (522, 275, 'COORDENAÇÃO-GERAL DE GESTÃO DE RISCOS', ' ', NULL, ' CGRIS', ' CGRIS - COORDENAÇÃO-GERAL DE GESTÃO DE RISCOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (526, 376, 'FUNDAÇÃO UNIVERSIDADE FEDERAL DE SÃO JOÃO DEL REI', ' ', NULL, ' UFSJ', ' UFSJ - FUNDAÇÃO UNIVERSIDADE FEDERAL DE SÃO JOÃO DEL REI');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (529, 275, 'SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 1ª REGIÃO FISCAL', ' ', NULL, ' SRRF01', ' SRRF01 - SUPERINTENDÊNCIA REGIONAL DA RECEITA FEDERAL DO BRASIL DA 1ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (532, 152, 'COORDENAÇÃO-GERAL DE ORÇAMENTO, FINANÇAS E ANÁLISE CONTÁBIL ', ' ', NULL, ' COGEF', ' COGEF - COORDENAÇÃO-GERAL DE ORÇAMENTO, FINANÇAS E ANÁLISE CONTÁBIL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (537, 275, 'COORDENAÇÃO ESPECIAL DE VIGILÂNCIA E REPRESSÃO', ' ', NULL, ' COREP-SRF', ' COREP-SRF - COORDENAÇÃO ESPECIAL DE VIGILÂNCIA E REPRESSÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (538, 461, 'AUDITORIA DA 7ª CONSULTORIA JURÍDICA DA MARINHA', ' ', NULL, ' PJF/JMU-AUDIT7ªCJM', ' PJF/JMU-AUDIT7ªCJM - AUDITORIA DA 7ª CONSULTORIA JURÍDICA DA MARINHA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (542, 10019, 'FUNDO DE APOSENTADORIAS E PENSÕES DOS SERVIDORES DO ESTADO DE PERNAMBUCO', ' ', NULL, ' FUNAPE', ' FUNAPE - FUNDO DE APOSENTADORIAS E PENSÕES DOS SERVIDORES DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (546, NULL, 'SINDICATO NACIONAL DOS AUDITORES-FISCAIS DA RFB - DELEGACIA SINDICAL NO CEARÁ', ' ', NULL, ' SINAFI-CE', ' SINAFI-CE - SINDICATO NACIONAL DOS AUDITORES-FISCAIS DA RFB - DELEGACIA SINDICAL NO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (552, 71, 'DIVISÃO DE TECNOLOGIA DA INFORMAÇÃO DA SRRF 8ª REGIÃO FISCAL ', ' ', NULL, ' DITEC8', ' DITEC8 - DIVISÃO DE TECNOLOGIA DA INFORMAÇÃO DA SRRF 8ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (556, 10026, 'SECRETARIA DE ESTADO DA FAZENDA NO PARÁ', 'Avenida Visconde de Souza Franco, 110 - Pedereira - CEP 66.053-000', NULL, ' EFAZ-PA', ' EFAZ-PA - SECRETARIA DE ESTADO DA FAZENDA NO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (559, 115, 'DIVISÃO DE TECNOLOGIA DA INFORMAÇÃO NA 4ª REGIÃO FISCAL ', ' ', NULL, ' DITEC4', ' DITEC4 - DIVISÃO DE TECNOLOGIA DA INFORMAÇÃO NA 4ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (562, 115, 'DIVISÃO DE INTERAÇÃO COM O CIDADÃO NA 4ª REGIÃO FISCAL ', ' ', NULL, ' DIVIC4', ' DIVIC4 - DIVISÃO DE INTERAÇÃO COM O CIDADÃO NA 4ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (565, 115, 'DIVISÃO DE REPRESSÃO AO CONTRABANDO E DESCAMINHO', ' ', NULL, ' DIREP', ' DIREP - DIVISÃO DE REPRESSÃO AO CONTRABANDO E DESCAMINHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (567, 115, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM RECIFE', ' ', NULL, ' DRF/REC', ' DRF/REC - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM RECIFE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (572, 115, 'SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES', ' ', NULL, ' SEMAC4', ' SEMAC4 - SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (576, 5, 'PROCURADORIA REGIONAL DA FAZENDA NACIONAL NO ESTADO DO PARÁ', ' ', NULL, ' PRFN-PA', ' PRFN-PA - PROCURADORIA REGIONAL DA FAZENDA NACIONAL NO ESTADO DO PARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (580, 143, 'COMISSÃO EXECUTIVA DO PLANO DA LAVOURA CACAUEIRA', ' ', NULL, ' CEPLAC', ' CEPLAC - COMISSÃO EXECUTIVA DO PLANO DA LAVOURA CACAUEIRA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (584, 152, 'GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO RIO GRANDE DO NORTE ', ' ', NULL, ' GRA/RN', ' GRA/RN - GERÊNCIA REGIONAL DE ADMINISTRAÇÃO NO RIO GRANDE DO NORTE ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (586, 22, 'SUPERINTENDÊNCIA REGIONAL DA POLÍCIA FEDERAL NO ESTADO DA BAHIA', ' ', NULL, ' 10ª SRPRF/BA', ' 10ª SRPRF/BA - SUPERINTENDÊNCIA REGIONAL DA POLÍCIA FEDERAL NO ESTADO DA BAHIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (590, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO EM CAMPINAS', 'Av. Francisco Glicério, 1477 - Centro - CEP 13012-000', NULL, ' DRJ/CPS', ' DRJ/CPS - DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO EM CAMPINAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (596, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO EM FLORIANÓPOLIS', 'Av. Othon Gama D''eça, 900 - 10º andar - Centro - CEP 88015-240', NULL, ' DRJ/FNS', ' DRJ/FNS - DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO EM FLORIANÓPOLIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (600, NULL, 'PROCURADORIA DA REPÚBLICA NO ESTADO DE SÃO PAULO', ' ', NULL, ' PR/SP', ' PR/SP - PROCURADORIA DA REPÚBLICA NO ESTADO DE SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (602, 366, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CUIABÁ ', 'Av. Vereador Juliano da Costa Marques, 99 - Bosque da Saúde - CEP 78050-600', NULL, ' DRF/CBA', ' DRF/CBA - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CUIABÁ ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (608, 10004, 'JUSTIÇA FEDERAL DE 1º GRAU EM SÃO PAULO', ' ', NULL, ' JF-SP', ' JF-SP - JUSTIÇA FEDERAL DE 1º GRAU EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (613, 10000, 'OUVIDORIA-GERAL', ' ', NULL, ' OUVIR', ' OUVIR - OUVIDORIA-GERAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (614, 10001, 'CENTRO ESTRATÉGICO DE EDUCAÇÃO À DISTÂNCIA', ' ', NULL, ' CEEAD', ' CEEAD - CENTRO ESTRATÉGICO DE EDUCAÇÃO À DISTÂNCIA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (615, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SÃO JOSÉ DO RIO PRETO', 'Rua Roberto Mange, 360 - Jd. Morumbi - CEP 15090-901', NULL, ' DRF/SJR', ' DRF/SJR - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM SÃO JOSÉ DO RIO PRETO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (620, 71, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL DE FISCALIZAÇÃO EM SÃO PAULO', 'Av. Pacaembu, 715, 5º andar Sala 512 - CEP 01234-001', NULL, ' DEFIS SÃO PAULO', ' DEFIS SÃO PAULO - DELEGACIA DA RECEITA FEDERAL DO BRASIL DE FISCALIZAÇÃO EM SÃO PAULO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (625, 152, 'COORDENAÇÃO DE DESENVOLVIMENTO DE RECURSOS HUMANOS', ' ', NULL, ' CODRH', ' CODRH - COORDENAÇÃO DE DESENVOLVIMENTO DE RECURSOS HUMANOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (626, 461, '2º CENTRO INTEGRADO DE DEFESA AÉREA E CONTROLE DE TRÁFEGO AÉREO', ' ', NULL, ' CINDACTA II', ' CINDACTA II - 2º CENTRO INTEGRADO DE DEFESA AÉREA E CONTROLE DE TRÁFEGO AÉREO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (629, NULL, 'ASSOCIAÇÃO GAÚCHA DOS AUDITORES-FISCAIS DA RECEITA FEDERAL DO BRASIL', ' ', NULL, ' AGAFRFB', ' AGAFRFB - ASSOCIAÇÃO GAÚCHA DOS AUDITORES-FISCAIS DA RECEITA FEDERAL DO BRASIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (633, 275, 'COORDENAÇÃO ESPECIAL DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES', ' ', NULL, ' COMAC', ' COMAC - COORDENAÇÃO ESPECIAL DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (637, 10033, 'SECRETARIA DE CONTROLE EXTERNO NO AMAZONAS ', ' ', NULL, ' SECEX-AM', ' SECEX-AM - SECRETARIA DE CONTROLE EXTERNO NO AMAZONAS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (639, NULL, 'SECRETARIA MUNICIPAL DE ECONOMIA E FINANÇAS NO ESTADO DO AMAZONAS', ' ', NULL, ' SEMEF-AM', ' SEMEF-AM - SECRETARIA MUNICIPAL DE ECONOMIA E FINANÇAS NO ESTADO DO AMAZONAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (645, 10000, 'ASSESSORIA ESPECIAL DE CONTROLE INTERNO DO GABINETE DO MINISTRO DA FAZENDA', ' ', NULL, ' AECGMF', ' AECGMF - ASSESSORIA ESPECIAL DE CONTROLE INTERNO DO GABINETE DO MINISTRO DA FAZENDA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (648, 192, 'SECRETARIA DE EXTRATIVISMO E DESENVOLVIMENTO RURAL SUSTENTÁVEL', ' ', NULL, 'SEDR', 'SEDR - SECRETARIA DE EXTRATIVISMO E DESENVOLVIMENTO RURAL SUSTENTÁVEL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (652, 436, 'REDE INTEGRADA DE SEGURANÇA ALIMENTAR E NUTRICIONAL', ' ', NULL, ' REDESAN', ' REDESAN - REDE INTEGRADA DE SEGURANÇA ALIMENTAR E NUTRICIONAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (653, 13, 'COORDENAÇÃO-GERAL DE SEGURIDADE SOCIAL E BENEFÍCIOS DO SERVIDOR', ' ', NULL, ' COGSS', ' COGSS - COORDENAÇÃO-GERAL DE SEGURIDADE SOCIAL E BENEFÍCIOS DO SERVIDOR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (656, 356, 'SECRETARIA DE RELAÇÕES INSTITUCIONAIS DA PRESIDÊNCIA DA REPÚBLICA', ' ', NULL, ' SRI/PR', ' SRI/PR - SECRETARIA DE RELAÇÕES INSTITUCIONAIS DA PRESIDÊNCIA DA REPÚBLICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (660, 213, 'ALFÂNDEGA AEROPORTO INTERNACIONAL PINTO MARTINS', ' ', NULL, ' ALF/APM', ' ALF/APM - ALFÂNDEGA AEROPORTO INTERNACIONAL PINTO MARTINS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (662, 227, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CONTAGEM ', ' ', NULL, ' DRF/COM', ' DRF/COM - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM CONTAGEM ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (666, 385, 'COORDENAÇÃO-GERAL DA UNIDADE DE COORDENAÇÃO DE PROGRAMAS', ' ', NULL, ' DIGE UCP', ' DIGE UCP - COORDENAÇÃO-GERAL DA UNIDADE DE COORDENAÇÃO DE PROGRAMAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (669, 10011, 'TRIBUNAL DE CONTAS DO ESTADO DE MINAS GERAIS ', ' ', NULL, ' TCE-MG', ' TCE-MG - TRIBUNAL DE CONTAS DO ESTADO DE MINAS GERAIS ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (673, 275, 'COORDENAÇÃO ESPECIAL DE RESSARCIMENTO, COMPENSAÇÃO E RESTITUIÇÃO', ' ', NULL, ' COREC', ' COREC - COORDENAÇÃO ESPECIAL DE RESSARCIMENTO, COMPENSAÇÃO E RESTITUIÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (676, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO CEARÁ', ' ', NULL, ' IF CE', ' IF CE - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO CEARÁ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (679, 10000, 'COODENAÇÃO-GERAL DE CONTABILIDADE DA UNIÃO', ' ', NULL, ' CCONT', ' CCONT - COODENAÇÃO-GERAL DE CONTABILIDADE DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (682, 227, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM GOVERNADOR VALADARES ', ' ', NULL, ' DRF/GVS', ' DRF/GVS - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM GOVERNADOR VALADARES ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (685, 13, 'INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA ', ' ', NULL, ' IBGE', ' IBGE - INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (687, NULL, 'PR/CC DA PR/SUBCHEFIA DE ANÁLISE E ACOMPANH.DE POLÍT. GOVERNAMENT./COORDEN. DE APOIO ADM.', ' ', NULL, ' SAPG-CC', ' SAPG-CC - PR/CC DA PR/SUBCHEFIA DE ANÁLISE E ACOMPANH.DE POLÍT. GOVERNAMENT./COORDEN. DE APOIO ADM.');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (692, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO PARÁ EM CASTANHAL', ' ', NULL, ' EAF-CCEAF/IF PA', ' EAF-CCEAF/IF PA - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO PARÁ EM CASTANHAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (696, 10031, 'SECRETARIA DE FAZENDA DO ESTADO DE SERGIPE', ' ', NULL, ' SEFAZ-SE', ' SEFAZ-SE - SECRETARIA DE FAZENDA DO ESTADO DE SERGIPE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (698, 227, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL EM UBERABA ', ' ', NULL, ' DRF/UBB', ' DRF/UBB - DELEGACIA DA RECEITA FEDERAL DO BRASIL EM UBERABA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (702, 10000, 'SUPERINTENDÊNCIA DE ADMINISTRAÇÃO EM PERNAMBUCO', ' ', NULL, ' SAMF-PE', ' SAMF-PE - SUPERINTENDÊNCIA DE ADMINISTRAÇÃO EM PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (706, 2200, 'PROCURADORIA DA REPÚBLICA NO RIO GRANDE DO SUL', ' ', NULL, ' PR-RS', ' PR-RS - PROCURADORIA DA REPÚBLICA NO RIO GRANDE DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (708, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA EM BAMBUÍ', ' ', NULL, ' IFMG - CAMPUS BAMBUÍ', ' IFMG - CAMPUS BAMBUÍ - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA EM BAMBUÍ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (712, 376, 'INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA BAHIA - CAMPUS DE BARREIRAS', ' ', NULL, ' IFBA', ' IFBA - INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DA BAHIA - CAMPUS DE BARREIRAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (714, 183, 'DIVISÃO DE REPRESSÃO AO CONTRABANDO E DESCAMINHO', ' ', NULL, ' DIREP09', ' DIREP09 - DIVISÃO DE REPRESSÃO AO CONTRABANDO E DESCAMINHO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (719, 183, 'DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA', ' ', NULL, ' DIPOL09', ' DIPOL09 - DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (722, 183, 'DIVISÃO DE TECNOLOGIA E SEGURANÇA DA INFORMAÇÃO', ' ', NULL, ' DITEC09', ' DITEC09 - DIVISÃO DE TECNOLOGIA E SEGURANÇA DA INFORMAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (725, 183, 'DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO EM CURITIBA ', 'Rua Conselheiro Laurindo, 2725 - Prado Velho - CEP 80215-210', NULL, ' DRJ/CTA', ' DRJ/CTA - DELEGACIA DA RECEITA FEDERAL DO BRASIL DE JULGAMENTO EM CURITIBA ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (730, 3, 'COORDENAÇÃO-GERAL DE CONTABILIDADE APLICADA À FEDERAÇÃO', ' ', NULL, ' CCONF', ' CCONF - COORDENAÇÃO-GERAL DE CONTABILIDADE APLICADA À FEDERAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (734, NULL, 'PREFEITURA MUNICIPAL DE IPATINGA', ' ', NULL, ' PMIp- MG', ' PMIp- MG - PREFEITURA MUNICIPAL DE IPATINGA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (736, 461, 'CENTRO DE INSTRUÇÃO ALMIRANTE BRAZ DE AGUIAR', ' ', NULL, ' CIABA', ' CIABA - CENTRO DE INSTRUÇÃO ALMIRANTE BRAZ DE AGUIAR');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (738, 79, 'NÚCLEO ESTADUAL DO MINISTÉRIO DA SAÚDE NO RIO GRANDE DO SUL ', ' ', NULL, ' NE/MS-RS', ' NE/MS-RS - NÚCLEO ESTADUAL DO MINISTÉRIO DA SAÚDE NO RIO GRANDE DO SUL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (1036, NULL, 'PREFEITURA DE FORTALEZA', ' ', NULL, ' PREF FORTALEZA', ' PREF FORTALEZA - PREFEITURA DE FORTALEZA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (5000, 461, 'COMANDO DA AERONÁUTICA', '" Esplanada dos Ministérios - Bloco ""M"" - 8º andar - CEP 70045-900"', NULL, ' COMAER', ' COMAER - COMANDO DA AERONÁUTICA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10002, 356, 'MINISTÉRIO DA CIÊNCIA, TECNOLOGIA E INOVAÇÃO', '"Esplanada dos Ministérios - Bloco ""E"" - CEP 70067-900"', NULL, ' MCTI', ' MCTI - MINISTÉRIO DA CIÊNCIA, TECNOLOGIA E INOVAÇÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10009, NULL, 'GOVERNO DO ESTADO DE ALAGOAS', ' ', NULL, ' AL', ' AL - GOVERNO DO ESTADO DE ALAGOAS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10012, NULL, 'GOVERNO DO ESTADO DO RIO GRANDE DO NORTE', ' ', NULL, ' RN', ' RN - GOVERNO DO ESTADO DO RIO GRANDE DO NORTE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10015, NULL, 'GOVERNO DO ESTADO DE SANTA CATARINA', ' ', NULL, ' SC', ' SC - GOVERNO DO ESTADO DE SANTA CATARINA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10019, NULL, 'GOVERNO DO ESTADO DE PERNAMBUCO', ' ', NULL, ' PE', ' PE - GOVERNO DO ESTADO DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10022, NULL, 'GOVERNO DO ESTADO DO ESPÍRITO SANTO', ' ', NULL, ' ES', ' ES - GOVERNO DO ESTADO DO ESPÍRITO SANTO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10025, NULL, 'GOVERNO DO ESTADO DO MATO GROSSO DO SUL', ' ', NULL, ' MS', ' MS - GOVERNO DO ESTADO DO MATO GROSSO DO SUL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10028, NULL, 'GOVERNO DO ESTADO DO PIAUÍ', ' ', NULL, ' PI', ' PI - GOVERNO DO ESTADO DO PIAUÍ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10031, NULL, 'GOVERNO DO ESTADO DE SERGIPE', ' ', NULL, ' SE', ' SE - GOVERNO DO ESTADO DE SERGIPE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10034, NULL, 'PREFEITURA DE CURITIBA', ' ', NULL, ' PREF CURITIBA', ' PREF CURITIBA - PREFEITURA DE CURITIBA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10036, 183, 'GABINETE DA SUPERINTENDÊNCIA DA 9ª REGIÃO FISCAL ', ' ', NULL, ' GABIN9', ' GABIN9 - GABINETE DA SUPERINTENDÊNCIA DA 9ª REGIÃO FISCAL ');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10038, 183, 'DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIANA9', ' DIANA9 - DIVISÃO DE ADMINISTRAÇÃO ADUANEIRA DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10041, 183, 'DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DIPOL9', ' DIPOL9 - DIVISÃO DE PROGRAMAÇÃO E LOGÍSTICA DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10044, 183, 'DIVISÃO DE TECNOLOGIA E SEGURANCA DA INFORMAÇÃO DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' DITEC9', ' DITEC9 - DIVISÃO DE TECNOLOGIA E SEGURANCA DA INFORMAÇÃO DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10046, 183, 'SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES DA SRRF 9ª REGIÃO FISCAL', ' ', NULL, ' SEMAC9', ' SEMAC9 - SERVIÇO DE ACOMPANHAMENTO DOS MAIORES CONTRIBUINTES DA SRRF 9ª REGIÃO FISCAL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10049, NULL, 'FUNDAÇÃO EDUCACIONAL DE DIVINÓPOLIS', ' Av. Paraná, 3001 - Jardim Belvedere - CEP 35501-170', NULL, ' FUNEDI', ' FUNEDI - FUNDAÇÃO EDUCACIONAL DE DIVINÓPOLIS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10050, 376, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA FARROUPILHA', ' Rua Esmeralda, 430 - Camobi - CEP 97010-100', NULL, ' IF FAR', ' IF FAR - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA FARROUPILHA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10053, NULL, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DE PERNAMBUCO', ' Praça Souto Filho, 696 - Heliópolis - CEP 55295-400', NULL, ' IFPE', ' IFPE - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DE PERNAMBUCO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10057, 13, 'SECRETARIA DO PATRIMÔNIO DA UNIÃO', '" Esplanada dos Ministérios - Bloco ""C"" - 2º andar - CEP 70046-900"', NULL, ' SPU', ' SPU - SECRETARIA DO PATRIMÔNIO DA UNIÃO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10060, 356, 'SECRETARIA NACIONAL DE JUVENTUDE', ' Praça dos Três Poderes - Palácio do Planalto - Anexo I, Ala B, Sala 107 - CEP 70150-900', NULL, ' SNJ', ' SNJ - SECRETARIA NACIONAL DE JUVENTUDE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10065, NULL, 'SECRETARIA DA RECEITA FEDERAL DO BRASIL', '" Esplanada dos Ministérios - Bloco ""P"" - CEP 70048-900"', NULL, ' SRFB', ' SRFB - SECRETARIA DA RECEITA FEDERAL DO BRASIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10069, 376, 'INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO PARANA', ' Rua João Negrão, 1285 - Rebouças - CEP 80230-150', NULL, ' IFPR', ' IFPR - INSTITUTO FEDERAL DE EDUCACAO, CIENCIA E TECNOLOGIA DO PARANA');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10076, 10000, 'COORDENACAO-GERAL DE PROGRAMAS E PROJETOS DE COOPERACAO', '" Esplanada dos Ministérios, Bloco ""P"" - 4º andar - CEP 70040-900"', NULL, ' COOPE', ' COOPE - COORDENACAO-GERAL DE PROGRAMAS E PROJETOS DE COOPERACAO');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10080, 115, 'ALFÂNDEGA NO PORTO DE SUAPE', 'Av. Portuária, s/nº - Rodovia PE 60, Km 10 - Engenho Massangana - CEP 55590-000', NULL, ' ALF/SPE', ' ALF/SPE - ALFÂNDEGA NO PORTO DE SUAPE');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10085, NULL, 'SUBSECRETARIA DE TRIBUTAÇÃO E CONTENCIOSO DA RECEITA FEDERAL DO BRASIL', ' ', NULL, ' SUTRI', ' SUTRI - SUBSECRETARIA DE TRIBUTAÇÃO E CONTENCIOSO DA RECEITA FEDERAL DO BRASIL');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10087, 356, 'SECRETARIA DE ASSUNTOS ESTRATÉGICOS', '" Esplanada dos Ministérios, Bloc ""O"", 7°, 8° e 9° andares - CEP "', NULL, ' SAE-PR', ' SAE-PR - SECRETARIA DE ASSUNTOS ESTRATÉGICOS');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10093, 10011, 'PREFEITURA MUNICIPAL DE CONTAGEM', ' ', NULL, ' PREF CONTAGEM', ' PREF CONTAGEM - PREFEITURA MUNICIPAL DE CONTAGEM');
INSERT INTO orgao (id_orgao, id_orgao_pai, nom_orgao, logradouro, tel_contato, sgl_orgao, nom_sigla) VALUES (10095, NULL, 'ESCOLA SUPERIOR ABERTA DO BRASIL LTDA.', ' Av. Santa Leopoldina, 840 - Coqueiral de Itaparica - CEP 29102-840', NULL, ' ESAB', ' ESAB - ESCOLA SUPERIOR ABERTA DO BRASIL LTDA.');
SELECT setval('orgao_id_orgao_seq', 10095);

/*==============================================================*/
/* Table: PACOTE                                                */
/*==============================================================*/
create table PACOTE (
   ID_PACOTE            SERIAL not null,
   ID_CURSO             INT4                 null,
   NOM_PACOTE           VARCHAR(256)         null,
   constraint PK_PACOTE primary key (ID_PACOTE)
);

comment on table PACOTE is
'Formado por uma coleção de oficinas. Por exemplo: um pacote CONTABILIDADE o qual contém as oficinas relacionadas.';

/*==============================================================*/
/* Table: PACOTE_OFICINA                                        */
/*==============================================================*/
create table PACOTE_OFICINA (
   ID_PACOTE_OFICINA    SERIAL not null,
   ID_OFICINA           INT4                 null,
   ID_PACOTE            INT4                 null,
   constraint PK_PACOTE_OFICINA primary key (ID_PACOTE_OFICINA)
);

comment on table PACOTE_OFICINA is
'Contém a relação entre pacote e oficinas.';

/*==============================================================*/
/* Table: PERFIL                                                */
/*==============================================================*/
create table PERFIL (
   ID_PERFIL            SERIAL not null,
   DSC_DESCRICAO        varchar(255)         not null,
   constraint PK_PERFIL primary key (ID_PERFIL)
);

INSERT INTO PERFIL (ID_PERFIL,DSC_DESCRICAO) VALUES (1,'SISFIE');
SELECT setval('perfil_id_perfil_seq', 1);

/*==============================================================*/
/* Table: PERFIL_FUNCIONALIDADE                                 */
/*==============================================================*/
 
create table PERFIL_FUNCIONALIDADE (
   ID_PERFIL_FUNCIONALIDADE SERIAL not null,
   ID_PERFIL            INT4                 null,
   ID_FUNCIONALIDADE    INT4                 null,
   constraint PK_PERFIL_FUNCIONALIDADE primary key (ID_PERFIL_FUNCIONALIDADE)
);

INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (1, 1, 1);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (2, 1, 2);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (3, 1, 3);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (4, 1, 4);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (5, 1, 5);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (6, 1, 6);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (7, 1, 7);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (8, 1, 8);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (9, 1, 9);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (10, 1, 10);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (11, 1,11);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (12, 1, 12);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (13, 1, 13);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (14, 1, 14);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (15, 1, 15);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (16, 1, 16);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (17, 1, 17);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (18, 1, 18);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (19, 1, 19);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (20, 1, 20);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (21, 1, 21);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (22, 1, 22);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (23, 1, 23);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (24, 1, 24);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (25, 1, 25);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (26, 1, 26);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (27, 1, 27);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (28, 1, 28);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (29, 1, 29);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (30, 1, 30);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (31, 1, 31);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (32, 1, 32);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (33, 1, 33);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (34, 1, 34);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (35, 1, 35);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (36, 1, 36);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (37, 1, 37);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (38, 1, 38);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (39, 1, 39);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (40, 1, 40);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (41, 1, 41);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (42, 1, 42);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (43, 1, 43);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (44, 1, 44);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (45, 1, 45);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (46, 1, 46);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (47, 1, 47);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (48, 1, 48);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (49, 1, 49);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (50, 1, 50);
INSERT INTO perfil_funcionalidade (id_perfil_funcionalidade, id_perfil, id_funcionalidade) VALUES (51, 1, 51);
SELECT setval('perfil_funcionalidade_id_perfil_funcionalidade_seq', 51);

/*==============================================================*/
/* Table: PROFESSOR_EVENTO                                      */
/*==============================================================*/
create table PROFESSOR_EVENTO (
   ID_PROFESSOR_EVENTO  SERIAL not null,
   ID_CANDIDATO         INT4                 null,
   ID_CURSO             INT4                 null,
   constraint PK_PROFESSOR_EVENTO primary key (ID_PROFESSOR_EVENTO)
);

/*==============================================================*/
/* Table: SALA                                                  */
/*==============================================================*/
create table SALA (
   ID_SALA              SERIAL not null,
   ID_CURSO             INT4                 null,
   NOM_SALA             VARCHAR(256)         null,
   NUM_CAPACIDADE       INT4                 null,
   DES_LOCALIZACAO      VARCHAR(256)         null,
   constraint PK_SALA primary key (ID_SALA)
);

comment on column SALA.DES_LOCALIZACAO is
'A localização da sala: edifício, andar etc. Foi sugerido ao cliente/usuário que este valor passasse a ser atómico, mas no momento ainda existe uma limitação, do cliente, para que esta modificação seja feita.';

/*==============================================================*/
/* Table: SELECAO_OFICINA                                       */
/*==============================================================*/
create table SELECAO_OFICINA (
   ID_SELECAO_OFICINA   SERIAL not null,
   ID_OFICINA           INT4                 null,
   ID_INSCRICAO_CURSO   INT4                 null,
   NUM_ORDEM_SELECAO    INT4                 not null,
   constraint PK_SELECAO_OFICINA primary key (ID_SELECAO_OFICINA)
);

comment on table SELECAO_OFICINA is
'Seleção de quais oficinas o candato gostaria de fazer de um determinado curso';

/*==============================================================*/
/* Table: SELECAO_PACOTE                                        */
/*==============================================================*/
create table SELECAO_PACOTE (
   ID_SELECAO_PACOTE    SERIAL not null,
   ID_PACOTE            INT4                 null,
   ID_INSCRICAO_CURSO   INT4                 not null,
   constraint PK_SELECAO_PACOTE primary key (ID_SELECAO_PACOTE)
);

comment on table SELECAO_PACOTE is
'Um candidato só pode selecionar um pacote por curso';

/*==============================================================*/
/* Table: SETOR_RESPONSAVEL_ESAF                                */
/*==============================================================*/
create table SETOR_RESPONSAVEL_ESAF (
   ID_SETOR_RESPONSAVEL_ESAF SERIAL not null,
   NOME_SETOR           VARCHAR(255)         not null,
   SIGLA                VARCHAR(50)          not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_SETOR_RESPONSAVEL_ESAF primary key (ID_SETOR_RESPONSAVEL_ESAF)
);

/*==============================================================*/
/* Table: SITUACAO_D                                            */
/*==============================================================*/
create table SITUACAO_D (
   ID_SITUACAO          SERIAL not null,
   DSC_SITUACAO         VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_SITUACAO_D primary key (ID_SITUACAO)
);

INSERT INTO situacao_d (id_situacao,dsc_situacao,flg_ativo) VALUES (1,'ESPERA',true);
INSERT INTO situacao_d (id_situacao,dsc_situacao,flg_ativo) VALUES (2,'INSCRITO',true);


SELECT setval('situacao_d_id_situacao_seq',2);

/*==============================================================*/
/* Table: STATUS_CURSO                                          */
/*==============================================================*/
create table STATUS_CURSO (
   ID_STATUS_CURSO      SERIAL not null,
   ID_STATUS            INT4                 not null,
   ID_CURSO             INT4                 not null,
   ID_USUARIO           INT4                 not null,
   DT_ATUALIZACAO       DATE                 not null,
   constraint PK_STATUS_CURSO primary key (ID_STATUS_CURSO)
);

/*==============================================================*/
/* Table: STATUS_D                                              */
/*==============================================================*/
create table STATUS_D (
   ID_STATUS            SERIAL not null,
   DSC_STATUS           VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_STATUS_D primary key (ID_STATUS)
);



INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (1,'Aguardando Comprovante',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (2,'Cancelado',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (3,'Presença confirmada',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (4,'Em andamento',true);

INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (5,'Cadastrado',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (6,'Finalizado Curso',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (7,'Suspenso',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (8,'Confirmado pelo chefe',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (9,'Finalizada as Inscrições',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (10,'Pré-Inscrito',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (11,'Aguardando Vaga',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (12,'Homologado',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (13,'Aguardando com prioridade',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (14,'Comprovante Inválido',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (15,'Aguardando validação comprovante',true);
INSERT INTO status_d (id_status,dsc_status,flg_ativo) VALUES (16,'Aguardando Homologação',true);
INSERT INTO status_d (id_status, dsc_status, flg_ativo) VALUES (17, 'Autorizar Pagamento', true);


SELECT setval('status_d_id_status_seq',17);

/*==============================================================*/
/* Table: STATUS_INSCRICAO                                      */
/*==============================================================*/
create table STATUS_INSCRICAO (
   ID_STATUS_INSCRICAO  SERIAL not null,
   ID_INSCRICAO_CURSO   INT4                 not null,
   ID_USUARIO           INT4                 not null,
   ID_STATUS            INT4                 not null,
   DT_ATUALIZACAO       DATE                 not null,
   constraint PK_STATUS_INSCRICAO primary key (ID_STATUS_INSCRICAO)
);

/*==============================================================*/
/* Table: TURMA                                                 */
/*==============================================================*/
create table TURMA (
   ID_TURMA             SERIAL not null,
   ID_CURSO             INT4                 not null,
   DESCRICAO            VARCHAR(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_TURMA primary key (ID_TURMA)
);

/*==============================================================*/
/* Table: TURNO                                                 */
/*==============================================================*/
create table TURNO (
   ID_TURNO             INT4                 not null,
   DES_TURNO            VARCHAR(20)          not null,
   constraint PK_TURNO primary key (ID_TURNO)
);

INSERT INTO TURNO (ID_TURNO,DES_TURNO) VALUES (1,'Matutino');
INSERT INTO TURNO (ID_TURNO,DES_TURNO) VALUES (2,'Vespertino');
INSERT INTO TURNO (ID_TURNO,DES_TURNO) VALUES (3,'Ambos');

/*==============================================================*/
/* Table: UF                                                    */
/*==============================================================*/
create table UF (
   ID_UF                SERIAL not null,
   SIGLA                VARCHAR(255)         not null,
   DESCRICAO            VARCHAR(255)         not null,
   constraint PK_UF primary key (ID_UF)
);



INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (11,'RONDONIA','RO');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (12,'ACRE','AC');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (13,'AMAZONAS','AM');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (14,'RORAIMA','RR');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (15,'PARA','PA');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (16,'AMAPA','AP');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (17,'TOCANTINS','TO');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (21,'MARANHAO','MA');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (22,'PIAUI','PI');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (23,'CEARA','CE');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (24,'RIO GRANDE DO NORTE','RN');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (25,'PARAIBA','PB');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (26,'PERNAMBUCO','PE');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (27,'ALAGOAS','AL');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (28,'SERGIPE','SE');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (29,'BAHIA','BA');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (31,'MINAS GERAIS','MG');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (32,'ESPIRITO SANTO','ES');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (33,'RIO DE JANEIRO','RJ');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (35,'SAO PAULO','SP');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (41,'PARANA','PR');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (42,'SANTA CATARINA','SC');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (43,'RIO GRANDE DO SUL','RS');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (50,'MATO GROSSO DO SUL','MS');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (51,'MATO GROSSO','MT');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (52,'GOIAS','GO');
INSERT INTO uf (ID_UF,DESCRICAO,SIGLA) VALUES (53,'DISTRITO FEDERAL','DF');

/*==============================================================*/
/* Table: UF_CURSO                                              */
/*==============================================================*/
create table UF_CURSO (
   ID_UF_CURSO          SERIAL not null,
   ID_UF                INT4                 not null,
   ID_CURSO             INT4                 not null,
   constraint PK_UF_CURSO primary key (ID_UF_CURSO)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   ID_USUARIO           SERIAL not null,
   ID_PERFIL            INT4                 null,
   ID_SETOR_RESPONSAVEL_ESAF INT4                 null,
   NOM_USUARIO          varchar(255)         not null,
   LOGIN                varchar(255)         not null,
   SENHA                varchar(255)         not null,
   EMAIL                varchar(255)         not null,
   FLG_ATIVO            BOOL                 not null,
   constraint PK_USUARIO primary key (ID_USUARIO)
);


INSERT INTO usuario (id_usuario, id_perfil, nom_usuario, login, senha, email, flg_ativo) VALUES (1, 1, 'SISFIE', 'sisfie', 'eca60b5bf5dda54e997520d228a991e2', 'sisfieHelp@gmail.com', true);

SELECT setval('usuario_id_usuario_seq',1);

alter table AREA_CONHECIMENTO_CURSO
   add constraint FK_AREA_CON_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table AREA_CONHECIMENTO_CURSO
   add constraint FK_AREA_CON_REFERENCE_AREA_CON foreign key (ID_AREA_CONHECIMENTO)
      references AREA_CONHECIMENTO (ID_AREA_CONHECIMENTO)
      on delete restrict on update restrict;

alter table ATUACAO_CANDIDATO
   add constraint FK_ATUACAO__REFERENCE_CANDIDAT foreign key (ID_CANDIDATO)
      references CANDIDATO (ID_CANDIDATO)
      on delete restrict on update restrict;

alter table ATUACAO_CANDIDATO
   add constraint FK_ATUACAO__REFERENCE_ATUACAO foreign key (ID_ATUACAO)
      references ATUACAO (ID_ATUACAO)
      on delete restrict on update restrict;

alter table CANDIDATO
   add constraint FK_CANDIDAT_FK_CANDID_MUNICIPI foreign key (ID_MUNICIPIO_ORGAO)
      references MUNICIPIO (ID_MUNICIPIO)
      on delete restrict on update restrict;

alter table CANDIDATO
   add constraint FK_CANDIDAT_REFERENCE_ORGAO foreign key (ID_ORGAO_DIVISAO)
      references ORGAO (ID_ORGAO)
      on delete restrict on update restrict;

alter table CANDIDATO
   add constraint FK_CANDIDAT_REFERENCE_MUNICIPI foreign key (ID_MUNICIPIO_ENDERECO)
      references MUNICIPIO (ID_MUNICIPIO)
      on delete restrict on update restrict;

alter table CANDIDATO_CARGO
   add constraint FK_CANDIDAT_REFERENCE_CANDIDAT foreign key (ID_CANDIDATO)
      references CANDIDATO (ID_CANDIDATO)
      on delete restrict on update restrict;

alter table CANDIDATO_CARGO
   add constraint FK_CANDIDAT_REFERENCE_CARGO foreign key (ID_CARGO)
      references CARGO (ID_CARGO)
      on delete restrict on update restrict;

alter table CANDIDATO_COMPLEMENTO
   add constraint FK_CANDIDAT_REFERENCE_CANDIDAT foreign key (ID_CANDIDATO)
      references CANDIDATO (ID_CANDIDATO)
      on delete restrict on update restrict;

alter table CANDIDATO_PREENCHIMENTO
   add constraint FK_CANDIDAT_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table CANDIDATO_PREENCHIMENTO
   add constraint FK_CANDIDAT_REFERENCE_CAMPO_PR foreign key (ID_CAMPO_PREENCHIMENTO)
      references CAMPO_PREENCHIMENTO (ID_CAMPO_PREENCHIMENTO)
      on delete restrict on update restrict;

alter table CREDICIAMENTO
   add constraint FK_CREDICIA_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_REFERENCE_LOCALIZA foreign key (ID_LOCALIZACAO)
      references LOCALIZACAO (ID_LOCALIZACAO)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_REFERENCE_OPCAO_LI foreign key (ID_OPCAO_LISTA_CAND)
      references OPCAO_LISTA_CANDIDATO (ID_OPCAO_LISTA_CAND)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_REFERENCE_AREA foreign key (ID_AREA)
      references AREA (ID_AREA)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_REFERENCE_USUARIO foreign key (ID_USUARIO_GESTOR)
      references USUARIO (ID_USUARIO)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_REFERENCE_ORGAO foreign key (ID_ORGAO_SOLICITANTE)
      references ORGAO (ID_ORGAO)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_REFERENCE_TURNO foreign key (ID_TURNO)
      references TURNO (ID_TURNO)
      on delete restrict on update restrict;

alter table DISTRIBUICAO_SOF_GRADE
   add constraint FK_DISTRIBU_REFERENCE_SELECAO_ foreign key (ID_SELECAO_OFICINA)
      references SELECAO_OFICINA (ID_SELECAO_OFICINA)
      on delete restrict on update restrict;

alter table DISTRIBUICAO_SOF_GRADE
   add constraint FK_DISTRIBU_REFERENCE_GRADE_OF foreign key (ID_GRADE_OFICINA)
      references GRADE_OFICINA (ID_GRADE_OFICINA)
      on delete restrict on update restrict;

alter table EMAIL_CURSO_PRIVADO
   add constraint FK_EMAIL_CU_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table ESFERA_CURSO
   add constraint FK_ESFERA_C_REFERENCE_ESFERA_G foreign key (ID_ESFERA_GOV)
      references ESFERA_GOVERNO (ID_ESFERA_GOV)
      on delete restrict on update restrict;

alter table ESFERA_CURSO
   add constraint FK_ESFERA_C_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table FREQUENCIA
   add constraint FK_FREQUENC_REFERENCE_GRADE_OF foreign key (ID_GRADE_OFICINA)
      references GRADE_OFICINA (ID_GRADE_OFICINA)
      on delete restrict on update restrict;

alter table FUNCIONALIDADE
   add constraint FK_FUNCIONA_REFERENCE_FUNCIONA foreign key (ID_FUNCIONAL_PAI)
      references FUNCIONALIDADE (ID_FUNCIONALIDADE)
      on delete restrict on update restrict;

alter table GRADE_OFICINA
   add constraint FK_GRADE_OF_REFERENCE_OFICINA foreign key (ID_OFICINA)
      references OFICINA (ID_OFICINA)
      on delete restrict on update restrict;

alter table GRADE_OFICINA
   add constraint FK_GRADE_OF_REFERENCE_SALA foreign key (ID_SALA)
      references SALA (ID_SALA)
      on delete restrict on update restrict;

alter table GRADE_OFICINA
   add constraint FK_GRADE_OF_REFERENCE_TURMA foreign key (ID_TURMA)
      references TURMA (ID_TURMA)
      on delete restrict on update restrict;

alter table GRADE_OFICINA
   add constraint FK_GRADE_OF_REFERENCE_PROFESSO foreign key (ID_PROFESSOR_EVENTO)
      references PROFESSOR_EVENTO (ID_PROFESSOR_EVENTO)
      on delete restrict on update restrict;

alter table GRADE_OFICINA
   add constraint FK_GRADE_OF_REFERENCE_HORARIO foreign key (ID_HORARIO)
      references HORARIO (ID_HORARIO)
      on delete restrict on update restrict;

alter table GRADE_PACOTE
   add constraint FK_GRADE_PA_REFERENCE_PACOTE_O foreign key (ID_PACOTE_OFICINA)
      references PACOTE_OFICINA (ID_PACOTE_OFICINA)
      on delete restrict on update restrict;

alter table GRADE_PACOTE
   add constraint FK_GRADE_PA_REFERENCE_HORARIO foreign key (ID_HORARIO)
      references HORARIO (ID_HORARIO)
      on delete restrict on update restrict;

alter table GRADE_PACOTE
   add constraint FK_GRADE_PA_REFERENCE_TURMA foreign key (ID_TURMA)
      references TURMA (ID_TURMA)
      on delete restrict on update restrict;

alter table HOMOLOGACAO_CURSO
   add constraint FK_HOMOLOGA_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table HOMOLOGACAO_CURSO
   add constraint FK_HOMOLOGA_REFERENCE_HOMOLOGA foreign key (ID_HOMOLOGACAO)
      references HOMOLOGACAO (ID_HOMOLOGACAO)
      on delete restrict on update restrict;

alter table HORARIO
   add constraint FK_HORARIO_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table INSCRICAO_COMPROVANTE
   add constraint FK_INSCRICA_REFERENCE_INSCRICA foreign key (ID_INSCRICAO_CURSO)
      references INSCRICAO_CURSO (ID_INSCRICAO_CURSO)
      on delete restrict on update restrict;

alter table INSCRICAO_CURSO
   add constraint FK_INSCRICA_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table INSCRICAO_CURSO
   add constraint FK_INSCRICA_REFERENCE_CANDIDAT foreign key (ID_CANDIDATO)
      references CANDIDATO (ID_CANDIDATO)
      on delete restrict on update restrict;

alter table INSCRICAO_CURSO
   add constraint FK_INSCRICA_REFERENCE_SITUACAO foreign key (ID_SITUACAO)
      references SITUACAO_D (ID_SITUACAO)
      on delete restrict on update restrict;

alter table INSCRICAO_CURSO
   add constraint FK_INSCRICA_REFERENCE_TURMA foreign key (ID_TURMA)
      references TURMA (ID_TURMA)
      on delete restrict on update restrict;

alter table INSCRICAO_ESFERA
   add constraint FK_INSCRICA_REFERENCE_INSCRICA foreign key (ID_INSCRICAO_CURSO)
      references INSCRICAO_CURSO (ID_INSCRICAO_CURSO)
      on delete restrict on update restrict;

alter table INSCRICAO_ESFERA
   add constraint FK_INSCRICA_REFERENCE_ESFERA_G foreign key (ID_ESFERA_GOV)
      references ESFERA_GOVERNO (ID_ESFERA_GOV)
      on delete restrict on update restrict;

alter table INSCRICAO_INFOR_COMPLEMENTAR
   add constraint FK_INSCRICA_REFERENCE_INSCRICA foreign key (ID_INSCRICAO_CURSO)
      references INSCRICAO_CURSO (ID_INSCRICAO_CURSO)
      on delete restrict on update restrict;

alter table INSCRICAO_INFOR_COMPLEMENTAR
   add constraint FK_INSCRICA_REFERENCE_ORGAO foreign key (ID_ORGAO)
      references ORGAO (ID_ORGAO)
      on delete restrict on update restrict;

alter table MUNICIPIO
   add constraint FK_MUNICIPI_REFERENCE_UF foreign key (ID_UF)
      references UF (ID_UF)
      on delete restrict on update restrict;

alter table MUNICIPIO_CURSO
   add constraint FK_MUNICIPI_REFERENCE_MUNICIPI foreign key (ID_MUNICIPIO)
      references MUNICIPIO (ID_MUNICIPIO)
      on delete restrict on update restrict;

alter table MUNICIPIO_CURSO
   add constraint FK_MUNICIPI_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table OFICINA
   add constraint FK_OFICINA_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table ORGAO
   add constraint FK_ORGAO_REFERENCE_ORGAO foreign key (ID_ORGAO_PAI)
      references ORGAO (ID_ORGAO)
      on delete restrict on update restrict;

alter table PACOTE
   add constraint FK_PACOTE_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table PACOTE_OFICINA
   add constraint FK_PACOTE_O_REFERENCE_OFICINA foreign key (ID_OFICINA)
      references OFICINA (ID_OFICINA)
      on delete restrict on update restrict;

alter table PACOTE_OFICINA
   add constraint FK_PACOTE_O_REFERENCE_PACOTE foreign key (ID_PACOTE)
      references PACOTE (ID_PACOTE)
      on delete restrict on update restrict;

alter table PERFIL_FUNCIONALIDADE
   add constraint FK_PERFIL_F_REFERENCE_FUNCIONA foreign key (ID_FUNCIONALIDADE)
      references FUNCIONALIDADE (ID_FUNCIONALIDADE)
      on delete restrict on update restrict;

alter table PERFIL_FUNCIONALIDADE
   add constraint FK_PERFIL_F_REFERENCE_PERFIL foreign key (ID_PERFIL)
      references PERFIL (ID_PERFIL)
      on delete restrict on update restrict;

alter table PROFESSOR_EVENTO
   add constraint FK_PROFESSO_REFERENCE_CANDIDAT foreign key (ID_CANDIDATO)
      references CANDIDATO (ID_CANDIDATO)
      on delete restrict on update restrict;

alter table PROFESSOR_EVENTO
   add constraint FK_PROFESSO_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table SALA
   add constraint FK_SALA_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table SELECAO_OFICINA
   add constraint FK_SELECAO__REFERENCE_OFICINA foreign key (ID_OFICINA)
      references OFICINA (ID_OFICINA)
      on delete restrict on update restrict;

alter table SELECAO_OFICINA
   add constraint FK_SELECAO__REFERENCE_INSCRICA foreign key (ID_INSCRICAO_CURSO)
      references INSCRICAO_CURSO (ID_INSCRICAO_CURSO)
      on delete restrict on update restrict;

alter table SELECAO_PACOTE
   add constraint FK_SELECAO__REFERENCE_PACOTE foreign key (ID_PACOTE)
      references PACOTE (ID_PACOTE)
      on delete restrict on update restrict;

alter table SELECAO_PACOTE
   add constraint FK_SELECAO__REFERENCE_INSCRICA foreign key (ID_INSCRICAO_CURSO)
      references INSCRICAO_CURSO (ID_INSCRICAO_CURSO)
      on delete restrict on update restrict;

alter table STATUS_CURSO
   add constraint FK_STATUS_C_REFERENCE_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
      on delete restrict on update restrict;

alter table STATUS_CURSO
   add constraint FK_STATUS_C_REFERENCE_STATUS_D foreign key (ID_STATUS)
      references STATUS_D (ID_STATUS)
      on delete restrict on update restrict;

alter table STATUS_CURSO
   add constraint FK_STATUS_C_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table STATUS_INSCRICAO
   add constraint FK_STATUS_I_FK_STATUS_STATUS_D foreign key (ID_STATUS)
      references STATUS_D (ID_STATUS)
      on delete restrict on update restrict;

alter table STATUS_INSCRICAO
   add constraint FK_STATUS_I_REFERENCE_INSCRICA foreign key (ID_INSCRICAO_CURSO)
      references INSCRICAO_CURSO (ID_INSCRICAO_CURSO)
      on delete restrict on update restrict;

alter table STATUS_INSCRICAO
   add constraint FK_STATUS_I_REFERENCE_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
      on delete restrict on update restrict;

alter table TURMA
   add constraint FK_TURMA_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table UF_CURSO
   add constraint FK_UF_CURSO_REFERENCE_UF foreign key (ID_UF)
      references UF (ID_UF)
      on delete restrict on update restrict;

alter table UF_CURSO
   add constraint FK_UF_CURSO_REFERENCE_CURSO foreign key (ID_CURSO)
      references CURSO (ID_CURSO)
      on delete restrict on update restrict;

alter table USUARIO
   add constraint FK_USUARIO_REFERENCE_PERFIL foreign key (ID_PERFIL)
      references PERFIL (ID_PERFIL)
      on delete restrict on update restrict;

alter table USUARIO
   add constraint FK_USUARIO_REFERENCE_SETOR_RE foreign key (ID_SETOR_RESPONSAVEL_ESAF)
      references SETOR_RESPONSAVEL_ESAF (ID_SETOR_RESPONSAVEL_ESAF)
      on delete restrict on update restrict;

