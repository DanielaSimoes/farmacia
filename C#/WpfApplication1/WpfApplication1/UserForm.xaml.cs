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
    /// Interaction logic for UserForm.xaml
    /// </summary>
    public partial class UserForm : Window
    {
        private static Index idx_page;
        private SqlConnection con;

        public UserForm()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        public UserForm(DataTable dt, DataTable dt_pres, Index idx)
        {
            InitializeComponent();
            users.ItemsSource = dt.DefaultView;
            prescriptions.ItemsSource = dt_pres.DefaultView;
            idx_page = idx;
            con = ConnectionDB.getConnection();
        }

        private void selected_btn_Click(object sender, RoutedEventArgs e)
        {
            DataRowView selectedItem = (DataRowView)prescriptions.SelectedItem;
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
                // listar medicamentos por numero perscricao
                string CmdString = "SELECT * FROM db.udf_prescricao_utente(@num_prescricao)";
                SqlCommand cmd = new SqlCommand(CmdString, con);
                cmd.Parameters.AddWithValue("@num_prescricao", item_code);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(idx_page.dt_grid_produtos);
                idx_page.produtosGrid.ItemsSource = idx_page.dt_grid_produtos.DefaultView;

                DateTime expires_at = (DateTime)selectedItem.Row.ItemArray[3];
                DateTime thisDay = DateTime.Today;
                int result = DateTime.Compare(expires_at, thisDay);
                if (result > 0)
                {
                    System.Windows.MessageBox.Show("The prescription has expired!");
                }


                this.Close();
            }
        }
    }
}
