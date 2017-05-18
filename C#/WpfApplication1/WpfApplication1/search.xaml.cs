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
    public partial class search : Page
    {
        private SqlConnection con;

        public search()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        private void tipo(object sender, RoutedEventArgs e)
        {
            if (TextBoxNomeTipo.Text.Length == 0 & TextBoxCodigoTipo.Text.Length == 0)
            {
                string CmdString = "SELECT * FROM db.tipo_data_grid(DEFAULT, DEFAULT)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("tipo");
                sda.Fill(dt);
                searchGrid.ItemsSource = dt.DefaultView;
            }
            else if (TextBoxNomeTipo.Text.Length != 0)
            {
                string CmdString = "SELECT * FROM db.tipo_data_grid(DEFAULT, @name)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@name", TextBoxNomeTipo.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("tipo");
                sda.Fill(dt);
                searchGrid.ItemsSource = dt.DefaultView;
            }
            else
            {
                string CmdString = "SELECT * FROM db.tipo_data_grid(@code, DEFAULT)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@code", TextBoxCodigoTipo.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("tipo");
                sda.Fill(dt);
                searchGrid.ItemsSource = dt.DefaultView;
            }
        }

        private void categoria(object sender, RoutedEventArgs e)
        {
            if (TextBoxNomeCategoria.Text.Length == 0 & TextBoxCodigoCategoria.Text.Length == 0)
            {
                string CmdString = "SELECT * FROM db.categoria_data_grid(DEFAULT, DEFAULT)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("categoria");
                sda.Fill(dt);
                searchGrid.ItemsSource = dt.DefaultView;
            }
            else if (TextBoxNomeCategoria.Text.Length != 0)
            {
                string CmdString = "SELECT * FROM db.categoria_data_grid(DEFAULT, @name)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@name", TextBoxNomeCategoria.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("categoria");
                sda.Fill(dt);
                searchGrid.ItemsSource = dt.DefaultView;
            }
            else
            {
                string CmdString = "SELECT * FROM db.categoria_data_grid(@code, DEFAULT)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@code", TextBoxCodigoCategoria.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("categoria");
                sda.Fill(dt);
                searchGrid.ItemsSource = dt.DefaultView;
            }
        }

    }
}
