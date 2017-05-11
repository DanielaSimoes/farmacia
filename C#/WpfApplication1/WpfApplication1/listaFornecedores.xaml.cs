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
    /// Interaction logic for listaFornecedores.xaml
    /// </summary>
    public partial class listaFornecedores : Page
    {
        private SqlConnection con;
        
        public listaFornecedores()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
            FillFornecedores();
        }

        private void FillFornecedores()
        {
            string CmdString = "SELECT * FROM db.udf_fornecedor_data_grid(DEFAULT)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("Fornecedores");
            sda.Fill(dt);
            listaFornecedoresGrid.ItemsSource = dt.DefaultView;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {

        }


    }
}
