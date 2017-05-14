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
    public partial class login : Page
    {
        private static int NIFInt;
        private SqlConnection con;
        SqlCommandBuilder cmb;
        SqlCommand cmd;
        SqlDataAdapter sda;

        public login()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();

        }

        public static int GetNIF(){
            return NIFInt;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
                
                if (!Int32.TryParse(TextBoxNIF.Text, out NIFInt))
                {
                    MessageBox.Show("The NIF must be an Integer!");
                    return;
                }
                string CmdString = "SELECT * FROM db.udf_login(@nif,@password)";
                cmd = new SqlCommand(CmdString, con);
                sda = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@nif", NIFInt);
                cmd.Parameters.AddWithValue("@password", TextBoxPassword.Password);
                DataTable dt = new DataTable("login");
                sda.Fill(dt);
                if (dt.Rows.Count == 0)
                {
                    MessageBox.Show("Password or NIF invalid!");
                }
                else
                {
                    Index index = new Index();
                    this.NavigationService.Navigate(index);
                }
           

        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void TextBox_TextChanged_1(object sender, TextChangedEventArgs e)
        {
        }
    }
}
