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
        SqlCommandBuilder cmb;
        DataTable dt = new DataTable("person");
        SqlCommand cmd;
        SqlDataAdapter sda;

        public dadosUtente()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
            FillDadosUtente();
        }

        private void FillDadosUtente()
        {
            string CmdString = "SELECT * FROM db.udf_pessoa_data_grid(DEFAULT)";
            cmd = new SqlCommand(CmdString, con);
            sda = new SqlDataAdapter(cmd);
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
                cmd = new SqlCommand(CmdString, con);
                sda = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@nif", NIFInt);
                DataTable dt = new DataTable("person");
                sda.Fill(dt);
                dadosUtenteGrid.ItemsSource = dt.DefaultView;
            }

        }

        private void dadosUtenteGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            try
            {
                DataRowView selectedItem = (DataRowView)dadosUtenteGrid.SelectedItem;
                int item_name = (int)selectedItem.Row.ItemArray[0];
                int item_NIF = (int)selectedItem.Row.ItemArray[1];
                int item_telefone = (int)selectedItem.Row.ItemArray[2];
                int item_data = (int)selectedItem.Row.ItemArray[3];
                int item_email = (int)selectedItem.Row.ItemArray[4];

                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    int dr_name = (int)dr["Name"];
                    int dr_NIF = (int)dr["NIF"];
                    int dr_telefone = (int)dr["Phone"];
                    int dr_data = (int)dr["Date of Birth"];
                    int dr_email = (int)dr["E-mail"];



                    string CmdString = "db.sp_ModifyUtente";
                    cmd = new SqlCommand(CmdString, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@nome", dr_name);
                    cmd.Parameters.AddWithValue("@dataNasc,", dr_data);
                    cmd.Parameters.AddWithValue("@email", dr_email);
                    cmd.Parameters.AddWithValue("@telefone", dr_telefone);
                    cmd.Parameters.AddWithValue("@NIF", dr_NIF);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        MessageBox.Show("ucesso!");
                    }
                    catch (Exception exc)
                    {
                        MessageBox.Show(exc.Message);
                    }
                }
            }
            catch (Exception)
            {

            }

        }
    }
}
