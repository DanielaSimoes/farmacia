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
using MahApps.Metro.Controls;


namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        private SqlConnection con;
        SqlCommandBuilder cmb;
        DataTable dt = new DataTable("prescricao");
        SqlCommand cmd;
        SqlDataAdapter sda;
         

        public MainWindow()
        {
            login log = new login(this);
            InitializeComponent();
            con = ConnectionDB.getConnection();
            Farmacia.initFarmacia();
            this.NavigateTo(log);
        }

        public void NavigateTo(object o)
        {
            Frame1.Navigate(o);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            definicoes definicoes_frame = new definicoes();
            string CmdString = "SELECT * FROM db.udf_period(@ID)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            cmd.Parameters.AddWithValue("@ID", 1);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("period");
            sda.Fill(dt);
            try
            {
                DataRow dr = dt.Rows[0];
                definicoes_frame.begin.Content = (int)dr["Begin"] + "h";
                definicoes_frame.end.Content = (int)dr["End"] + "h";
            }
            catch
            {

            }
            
            this.NavigateTo(definicoes_frame);

        }

        private void menu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string selectedText = (sender as ComboBox).SelectedItem.ToString().Split(new string[] { ": " }, StringSplitOptions.None).Last();

            if (selectedText.Equals("List Stock"))
            {
                produtos produtos_frame = new produtos();
                this.NavigateTo(produtos_frame);
            }
            Console.WriteLine(selectedText);
            
            if (selectedText.Equals("Home"))
            {
                try
                {
                    Index index = new Index();
                    this.NavigateTo(index);
                }
                catch (Exception)
                {

                }
            }
            
            Console.WriteLine(selectedText);

            if (selectedText.Equals("View User Data"))
            {
                dadosUtente dadosUtente_frame = new dadosUtente();
                this.NavigateTo(dadosUtente_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("List Prices"))
            {
                precos precos_frame = new precos();
                this.NavigateTo(precos_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("User History"))
            {
                historico historico_frame = new historico();
                this.NavigateTo(historico_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Add Employee"))
            {
                criarFuncionario criar_frame = new criarFuncionario();
                this.NavigateTo(criar_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Add Meds"))
            {
                criarMedicamento criarMeds_frame = new criarMedicamento();
                this.NavigateTo(criarMeds_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Logout"))
            {
                login login_frame = new login(this);
                this.NavigateTo(login_frame);
                this.menu.Visibility = Visibility.Hidden;
                this.definitions.Visibility = Visibility.Hidden;
            }
            Console.WriteLine(selectedText);
        }
    }
}
