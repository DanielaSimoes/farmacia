using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data;
using System.Data.SqlClient;

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for Page1.xaml
    /// </summary>
    public partial class criarUtente : Page
    {
        private SqlConnection con;

        public criarUtente()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int telefone_int, nif_int, numero_int;
            DateTime dt;

            string CmdString = "db.sp_createUtente";
            SqlCommand cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;


            try
            {
                cmd_member.Parameters.AddWithValue("@nome", nome.Text);
            }
            catch (Exception)
            {
            }

            try
            {
                if (Int32.TryParse(numero.Text, out numero_int))
                {
                    cmd_member.Parameters.AddWithValue("@num_utente", numero_int);
                }
                else
                {
                    MessageBox.Show("The user number must be an Integer!");
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The user number must be provided!");
                return;
            }

            try
            {
                if (Int32.TryParse(telefone.Text, out telefone_int))
                {
                    cmd_member.Parameters.AddWithValue("@telefone", telefone_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The telefone number must be an Integer!");
                return;
            }

            try
            {
                if (DateTime.TryParse(data.Text, out dt))
                {
                    
                    cmd_member.Parameters.AddWithValue("@dataNasc", dt);
                }
            }
            
            catch (Exception)
            {
                MessageBox.Show("Please insert a valid date!");
                return;
            }

            try
            {
                if (Int32.TryParse(nif.Text, out nif_int))
                {
                    cmd_member.Parameters.AddWithValue("@NIF", nif_int);
                }
                else
                {
                    MessageBox.Show("The NIF number must be an Integer!");
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The NIF must be provided!");
                return;
            }

            try
            {
                cmd_member.Parameters.AddWithValue("@morada", morada.Text);
            }
            catch (Exception)
            {
            }

            try
            {
                cmd_member.Parameters.AddWithValue("@email", email.Text);
            }
            catch (Exception)
            {
            }

       
            try
            {
                con.Open();
                cmd_member.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception exc)
            {
                con.Close();
                MessageBox.Show(exc.Message);
            }

            MessageBox.Show("User added!");
        }

        private void nome_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
