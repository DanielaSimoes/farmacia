using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WpfApplication1
{
    class Farmacia
    {
        public static int NIPC;
        public static int fax;
        public static int telefone;
        public static string nome;
        public static string localizacao;
        public static string email;
        private static SqlConnection con;

        static Farmacia()
        {
            NIPC = 1;
            fax = 234607201;
            telefone = 234607201;
            nome = "Farmacia Ajuda";
            localizacao = "Agueda";
            email = "ajuda@farmacias.pt";
            con = ConnectionDB.getConnection();
        }

        public static void initFarmacia(){

            // create farmacia if not exists

            string CmdString = "db.sp_createFarmacia";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@NIPC", NIPC);
            cmd.Parameters.AddWithValue("@fax", fax);
            cmd.Parameters.AddWithValue("@telefone", telefone);
            cmd.Parameters.AddWithValue("@nome", fax);
            cmd.Parameters.AddWithValue("@localizacao", localizacao);
            cmd.Parameters.AddWithValue("@email", email);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception exc)
            {
                con.Close();
                Console.WriteLine(exc.Message);
            }
        }
    }
}
