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
    public partial class precos : Page
    {
        private SqlConnection con;

        public precos()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
            FillPrecos();
        }

        private void FillPrecos()
        {
            string CmdString = "SELECT * FROM db.udf_preco_data_grid(DEFAULT)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("precos");
            sda.Fill(dt);
            precosGrid.ItemsSource = dt.DefaultView;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (TextBoxNome.Text.Length == 0 & TextBoxCodigo.Text.Length == 0)
            {
                FillPrecos();
            }
            else if (TextBoxCodigo.Text.Length == 0)
            {
                string CmdString = "SELECT * FROM db.udf_preco_data_grid(@nome)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@nome", TextBoxNome.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("precos");
                sda.Fill(dt);
                precosGrid.ItemsSource = dt.DefaultView;
            }
            else
            {
                string CmdString = "SELECT * FROM db.udf_preco_data_grid(@codigo)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@codigo", TextBoxNome.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("precos");
                sda.Fill(dt);
                precosGrid.ItemsSource = dt.DefaultView;
            }
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {

        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
