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
            DataRowView selectedItem = (DataRowView)dadosUtenteGrid.SelectedItem;

            string CmdString = "db.sp_modifyPessoa";
            cmd = new SqlCommand(CmdString, con);
            cmd.CommandType = CommandType.StoredProcedure;

            // nome
            try
            {
                string item_name = (string)selectedItem.Row.ItemArray[0];
                cmd.Parameters.AddWithValue("@nome", item_name);
            }
            catch (Exception)
            {
                MessageBox.Show("The name must be provided!");
                return;
            }


            // NIF
            int NIFInt;

            try
            {
                NIFInt = (int)selectedItem.Row.ItemArray[1];
                cmd.Parameters.AddWithValue("@NIF", NIFInt);
            }
            catch
            {
                MessageBox.Show("The NIF must be an Integer!");
                return;
            }

            // telefone
            try
            {
                int item_telefone = (int)selectedItem.Row.ItemArray[2];
                cmd.Parameters.AddWithValue("@telefone", item_telefone);
            }
            catch (Exception)
            {
            }

            // date
            try
            {
                DateTime item_data = (DateTime)selectedItem.Row.ItemArray[3];
                cmd.Parameters.AddWithValue("@dataNasc", item_data);
            }
            catch (Exception)
            {
            }


            //email
            try
            {
                string item_email = (string)selectedItem.Row.ItemArray[4];
                cmd.Parameters.AddWithValue("@email", item_email);
            }
            catch (Exception)
            {
            }

           
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
                con.Close();
            }
        }
    }
}
