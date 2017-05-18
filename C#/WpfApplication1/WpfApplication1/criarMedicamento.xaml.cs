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
    public partial class criarMedicamento : Page
    {
        private SqlConnection con;

        public criarMedicamento()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int idLab_int, codigo_int, quantidade_int, categoria_int, tipo_int;

            if (!Int32.TryParse(ID_lab.Text, out idLab_int))
            {
                MessageBox.Show("The ID Lab must be an Integer!");
                return;
            }

            if (!Int32.TryParse(codigo.Text, out codigo_int))
            {
                MessageBox.Show("The code number must be an Integer!");
                return;
            }

            if (!Int32.TryParse(quantidade.Text, out quantidade_int))
            {
                MessageBox.Show("The amount must be an Integer!");
                return;
            }

            if (!Int32.TryParse(quantidade.Text, out categoria_int))
            {
                MessageBox.Show("The amount must be an Integer!");
                return;
            }

            if (!Int32.TryParse(quantidade.Text, out tipo_int))
            {
                MessageBox.Show("The amount must be an Integer!");
                return;
            }

            string CmdString = "db.sp_createMedicamento";
            SqlCommand cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;
            cmd_member.Parameters.AddWithValue("@nome", nome.Text);
            cmd_member.Parameters.AddWithValue("@lab_id", idLab_int);
            cmd_member.Parameters.AddWithValue("@codigo", codigo_int);
            cmd_member.Parameters.AddWithValue("@categoria_id", categoria_int);
            cmd_member.Parameters.AddWithValue("@tipo_id", tipo_int);
            cmd_member.Parameters.AddWithValue("@quantidade", quantidade_int);
            cmd_member.Parameters.AddWithValue("@validade", "10/02/2010");
            cmd_member.Parameters.AddWithValue("@dose", 2);
            cmd_member.Parameters.AddWithValue("@unidades", 5);

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
            
        }
    }
}
