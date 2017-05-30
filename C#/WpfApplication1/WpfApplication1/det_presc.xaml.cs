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
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class det_presc : Window
    {
        private static historico his_page;
        private SqlConnection con;
        DataTable dt1;
        historico his1;

        public det_presc()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        public det_presc(DataTable dt, historico his)
        {
            InitializeComponent();
            dt1 = dt;
            his1 = his;
            DataRow dr = dt.Rows[0];

            name.Content = (string)dr["Name"];
            lab.Content = (int)dr["Lab"];
            qty.Content = (int)dr["Qty"];
            code.Content = (int)dr["Code"];
            price.Content = (int)dr["Price"] + "€";

            con = ConnectionDB.getConnection();
            his_page = his;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String selectedItem = combo.SelectedIndex.ToString();
            DataRow dr = dt1.Rows[Int32.Parse(selectedItem)];

            name.Content = (string)dr["Name"];
            lab.Content = (int)dr["Lab"];
            qty.Content = (int)dr["Qty"];
            code.Content = (int)dr["Code"];
            price.Content = (int)dr["Price"] + "€";

            con = ConnectionDB.getConnection();
            his_page = his1;

        }

    }
}
