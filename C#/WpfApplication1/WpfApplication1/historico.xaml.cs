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
                int NIFInt;

                if (!Int32.TryParse(TextBoxNIF.Text, out NIFInt))
                {
                    MessageBox.Show("The NIF must be an Integer!");
                    return;
                }


                string CmdString = "SELECT * FROM db.udf_historico_pres_data_grid(@nif)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@nif", NIFInt);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("prescricoes");
                sda.Fill(dt);
                historicoPrescrGrid.ItemsSource = dt.DefaultView;

                CmdString = "SELECT * FROM db.udf_historico_meds_data_grid(@nif)";
                cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@nif", NIFInt);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable("meds");
                sda.Fill(dt);
                historicoMedsGrid.ItemsSource = dt.DefaultView;
            }
        }

        private void Button_Click1(object sender, RoutedEventArgs e)
        {
            DataRowView selectedItem = (DataRowView)historicoPrescrGrid.SelectedItem;
            int item_code;

            try
            {
                item_code = (int)selectedItem.Row.ItemArray[0];
            }
            catch (Exception)
            {
                System.Windows.Forms.MessageBox.Show("Select one prescription!");
                return;
            }

            if (item_code != null)
            {
                det_presc det = new det_presc();
                string CmdString = "SELECT * FROM db.udf_prescricao_utente(@num_prescricao)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@num_prescricao", item_code);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(det.detpresc);
                det.presc.ItemsSource = det.detpresc.DefaultView;

                det.Show();
            }
        }

        private void historicoPrescrGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

       
    }
}
