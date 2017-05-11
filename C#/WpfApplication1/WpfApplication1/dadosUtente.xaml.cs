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
using System.Data.SqlClient;
using System.Data;

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for Page1.xaml
    /// </summary>
    public partial class dadosUtente : Page
    {

        private SqlConnection con;

        public dadosUtente()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
            FillDadosUtente();
        }

        private void FillDadosUtente()
        {
            string CmdString = "SELECT * FROM db.udf_pessoa_data_grid(DEFAULT)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("person");
            sda.Fill(dt);
            dadosUtenteGrid.ItemsSource = dt.DefaultView;
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int NIFInt;

            if (!Int32.TryParse(TextBoxNIF.Text, out NIFInt))
            {
                MessageBox.Show("The NIF must be an Integer!");
                return;
            }

            if (TextBoxNIF.Text.Length == 0)
            {
                FillDadosUtente();
            }
            else
            {
                string CmdString = "SELECT * FROM db.udf_pessoa_data_grid(@nif)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@nif", NIFInt);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("person");
                sda.Fill(dt);
                dadosUtenteGrid.ItemsSource = dt.DefaultView;
            }

        }
    }
}
