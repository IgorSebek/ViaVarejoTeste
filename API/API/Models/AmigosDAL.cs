using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace API.Models
{
    public class AmigosDAL
    {

        String conexao = ConfigurationManager.ConnectionStrings["conexao"].ConnectionString;


        public List<Amigos> retornaAmigos()
        {
            SqlConnection conn = new SqlConnection(conexao);
            conn.Open();

            string sql = "select id_amigo,nome From tb_amigos";
            Amigos amigos = new Amigos();

            List<Amigos> lista = new List<Amigos>();
            SqlDataReader dr = new SqlCommand(sql, conn).ExecuteReader();

            while (dr.Read())
            {
                amigos = new Amigos();
                amigos.nome = dr["nome"].ToString();

                lista.Add(amigos);
            }

            return lista;
        }


        public List<Amigos> retornaDadosAmigos()
        {
            SqlConnection conn = new SqlConnection(conexao);
            conn.Open();

            string sql = @"select amigos.nome,amigos.id_amigo,al.latitude,al.longitude from tb_amigos amigos
                            left JOIN tb_amigos_lat_long al on al.id_amigo = amigos.id_amigo";

            Amigos amigos = new Amigos();

            List<Amigos> lista = new List<Amigos>();
            SqlDataReader dr = new SqlCommand(sql, conn).ExecuteReader();

            while (dr.Read())
            {
                amigos = new Amigos();
                amigos.latitude= dr["latitude"].ToString();
                amigos.longitude= dr["longitude"].ToString();
                amigos.nome = dr["nome"].ToString();

                lista.Add(amigos);
            }

            return lista;
        }

        public string retornaStatusToken(string usuario,string senha)
        {
            string retorno = "0";
            SqlConnection conn = new SqlConnection(conexao);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();

            string sql = @"exec sp_valida_login @usuario,@senha";
            cmd.Parameters.AddWithValue("@usuario",usuario);
            cmd.Parameters.AddWithValue("@senha", senha);
            cmd.CommandText = sql;
            Amigos amigos = new Amigos();

            SqlDataReader dr = cmd.ExecuteReader(); 

            while (dr.Read())
            {
                retorno = dr["liberado"].ToString();
            }

            return retorno;
        }


    }
}