GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_amigos](
	[id_amigo] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_amigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_amigos_lat_long](
	[id_lat_long] [int] IDENTITY(1,1) NOT NULL,
	[id_amigo] [int] NULL,
	[latitude] [varchar](100) NULL,
	[longitude] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_lat_long] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_amigos_lat_long]  WITH CHECK ADD  CONSTRAINT [fk_amigos_lat_long] FOREIGN KEY([id_amigo])
REFERENCES [dbo].[tb_amigos] ([id_amigo])
GO
ALTER TABLE [dbo].[tb_amigos_lat_long] CHECK CONSTRAINT [fk_amigos_lat_long]
GO

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_relac_usu_amigo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_amigo] [int] NOT NULL
) ON [PRIMARY]
GO

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_status_token](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[token] [varchar](100) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[dt_ativo] [datetime] NOT NULL,
	[dt_vencimento] [datetime] NOT NULL
) ON [PRIMARY]
GO

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](100) NOT NULL,
	[senha] [varchar](10) NOT NULL
) ON [PRIMARY]
GO

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_valida_login] @login varchar(10),@senha varchar(10),@opcao int
as
begin 

declare @acesso_liberado int
declare @id_usuario int
declare @token varchar(100)

select @id_usuario=id from tb_usuario where login=@login and senha=@senha
select top 1 @token=token from tb_status_token where id_usuario=@id_usuario order by id desc
select @acesso_liberado=token_ativo from fn_status_token(@token)

	if (@id_usuario is not null and @token is null) or (@id_usuario is not null and @acesso_liberado=0 and @opcao=1)
	begin
		INSERT INTO tb_status_token(token,dt_ativo,dt_vencimento,id_usuario)
		select NEWID(),GETDATE(),DATEADD(MINUTE,5,GETDATE()),@id_usuario
		set @acesso_liberado=1
	end

	select @acesso_liberado liberado
end
GO


INSERT INTO tb_amigos(nome)
	VALUES('ISEBEK'),
	('LUCAS SEBEK'),
	('THIAGO SEBEK'),
	('EDUARDA SEBEK'),
	('APARECIDA SEBEK'),
	('MARIA DO CARMO'),
	('JOSÉ SEBEK') 

INSERT INTO tb_usuario(login,senha)
	VALUES('ISEBEK','VIAVAREJO'),
	('LSEBEK','VIAVAREJO'),
	('TSEBEK','VIAVAREJO'),
	('ESEBEK','VIAVAREJO'),
	('ASEBEK','VIAVAREJO'),
	('MCARMO','VIAVAREJO'),
	('JSEBEK','VIAVAREJO')

	INSERT INTO tb_relac_usu_amigo(id_amigo,id_usuario)
VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7)

INSERT INTO tb_amigos_lat_long(id_amigo,latitude,longitude)
VALUES
(1,'-23.7225239','-46.5755651'),
(2,'-23.724822','-46.564458'),
(3,'-23.724857','-46.565299'),
(4,'-23.723150','-46.565225'),
(5,'-23.720299','-46.568289'),
(6,'-23.677011','-46.535858'),
(7,'-23.628186','-46.559549')


