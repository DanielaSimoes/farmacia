using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;

namespace WpfApplication1
{
   
    class ConnectionDB
    {
        private static SqlConnection con;
        static ConnectionDB()
        {

            string ConString = ConfigurationManager.ConnectionStrings["ConStringDaniela"].ConnectionString; 
            // string ConString = ConfigurationManager.ConnectionStrings["ConStringCristiana"].ConnectionString;
            con = new SqlConnection(ConString);
        }
        public static SqlConnection getConnection()
        {
            return con;
        }
    }
}
