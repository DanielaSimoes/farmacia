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
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private SqlConnection con;
        SqlCommandBuilder cmb;
        DataTable dt = new DataTable("perscricao");
        SqlCommand cmd;
        SqlDataAdapter sda;

        public MainWindow()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
       
            Farmacia.initFarmacia();
            Index index = new Index();
            this.NavigateTo(index);
        }

        public void NavigateTo(object o)
        {
            Frame1.Navigate(o);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            definicoes definicoes_frame = new definicoes();

        }

        private void menu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string selectedText = (sender as ComboBox).SelectedItem.ToString().Split(new string[] { ": " }, StringSplitOptions.None).Last();

            if (selectedText.Equals("Check Stock"))
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

            if (selectedText.Equals("Check Prices"))
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

            if (selectedText.Equals("Add User"))
            {
                criarUtente criarUtente_frame = new criarUtente();
                this.NavigateTo(criarUtente_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Exit"))
            {
                login login_frame = new login();
                this.NavigateTo(login_frame);
                this.Visibility.Equals("Hidden");
            }
            Console.WriteLine(selectedText);
        }
    }
}
