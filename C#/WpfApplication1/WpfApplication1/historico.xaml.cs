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
    public partial class historico : Page
    {
        private SqlConnection con;

        public historico()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
            FillPrescriptions();
            FillMeds();
        }

        private void FillPrescriptions()
        {
            string CmdString = "SELECT * FROM db.udf_historico_pres_data_grid(DEFAULT)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("prescricoes");
            sda.Fill(dt);
            historicoPrescrGrid.ItemsSource = dt.DefaultView;
        }

        private void FillMeds()
        {
            string CmdString = "SELECT * FROM db.udf_historico_meds_data_grid(DEFAULT)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("meds");
            sda.Fill(dt);
            historicoMedsGrid.ItemsSource = dt.DefaultView;
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            if (TextBoxNIF.Text.Length == 0)
            {
                FillPrescriptions();
                FillMeds();
            }
            else
            {
                string CmdString = "SELECT * FROM db.udf_historico_pres_data_grid(@nif)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@nif", TextBoxNIF.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("prescricoes");
                sda.Fill(dt);
                historicoPrescrGrid.ItemsSource = dt.DefaultView;

                CmdString = "SELECT * FROM db.udf_historico_meds_data_grid(@nif)";
                cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@nif", TextBoxNIF.Text);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable("meds");
                sda.Fill(dt);
                historicoPrescrGrid.ItemsSource = dt.DefaultView;
            }
        }
    }
}
