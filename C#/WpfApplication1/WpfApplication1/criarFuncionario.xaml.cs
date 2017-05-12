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
    public partial class criarFuncionario : Page
    {
        private SqlConnection con;

        public criarFuncionario()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int telefone_int, nif_int, numero_int;

            if (!Int32.TryParse(telefone.Text, out telefone_int))
            {
                MessageBox.Show("The telefone number must be an Integer!");
                return;
            }

            if (!Int32.TryParse(nif.Text, out nif_int))
            {
                MessageBox.Show("The NIF number must be an Integer!");
                return;
            }

            if (!Int32.TryParse(numero.Text, out numero_int))
            {
                MessageBox.Show("The employee number must be an Integer!");
                return;
            }

            DateTime dt;
            if (!DateTime.TryParse(data.Text, out dt))
            {
                MessageBox.Show("Please insert a valid date!");
                return;
            }

            string CmdString = "db.sp_createPessoa";
            SqlCommand cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;
            cmd_member.Parameters.AddWithValue("@nome", nome.Text);
            cmd_member.Parameters.AddWithValue("@NIF", nif_int);
            cmd_member.Parameters.AddWithValue("@telefone", telefone_int);
            cmd_member.Parameters.AddWithValue("@dataNasc", dt);
            cmd_member.Parameters.AddWithValue("@email", email.Text);

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

            CmdString = "db.sp_createFuncionario";
            cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;
            cmd_member.Parameters.AddWithValue("@funcao", nif_int);
            cmd_member.Parameters.AddWithValue("@num_funcionario", numero_int);
            cmd_member.Parameters.AddWithValue("@pass", funcao.Text);
            cmd_member.Parameters.AddWithValue("@NIF", nif_int);

            try
            {
                con.Open();
                cmd_member.ExecuteNonQuery();
               
                con.Close();
                MessageBox.Show("The employee has been inserted successfully!");
            }
            catch (Exception exc)
            {
                con.Close();
                MessageBox.Show(exc.Message);
            }
        }
    }
}
