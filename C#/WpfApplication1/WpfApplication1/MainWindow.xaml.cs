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
            Index index = new Index();
            this.NavigateTo(index);
        }

        public void NavigateTo(object o)
        {
            Frame1.Navigate(o);
        }

        private void menu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string selectedText = (sender as ComboBox).SelectedItem.ToString().Split(new string[] { ": " }, StringSplitOptions.None).Last();

            if (selectedText.Equals("Verificar Stock"))
            {
                produtos produtos_frame = new produtos();
                this.NavigateTo(produtos_frame);
            }
            Console.WriteLine(selectedText);
            
            if (selectedText.Equals("Página Inicial"))
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
            
            if (selectedText.Equals("Ver Dados do Utente"))
            {
                dadosUtente dadosUtente_frame = new dadosUtente();
                this.NavigateTo(dadosUtente_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Verificar Preços"))
            {
                precos precos_frame = new precos();
                this.NavigateTo(precos_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Histórico do Utente"))
            {
                historico historico_frame = new historico();
                this.NavigateTo(historico_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Adicionar Funcionário"))
            {
                criarFuncionario criar_frame = new criarFuncionario();
                this.NavigateTo(criar_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Adicionar Utente"))
            {
                criarUtente criarUtente_frame = new criarUtente();
                this.NavigateTo(criarUtente_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Sair"))
            {
                login login_frame = new login();
                this.NavigateTo(login_frame);
                this.Visibility.Equals("Hidden");
            }
            Console.WriteLine(selectedText);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            definicoes definicoes_frame = new definicoes();
            this.NavigateTo(definicoes_frame);

        }

        private void Button_Click1(object sender, RoutedEventArgs e)
        {
            
            string CmdString = "SELECT * FROM db.udf_pessoa_data_grid(@utente_NIF)";
            cmd = new SqlCommand(CmdString, con);
            sda = new SqlDataAdapter(cmd);
            Index index = new Index();
            cmd.Parameters.AddWithValue("@utente_NIF", index.SeeNIF);
            DataTable dt = new DataTable("person");
            sda.Fill(dt);
            detalhes_prescricoes det = new detalhes_prescricoes();
            det.historicoPrescrGrid.ItemsSource = dt.DefaultView;


            detalhes_prescricoes detalhes_frame = new detalhes_prescricoes();
            this.NavigateTo(detalhes_frame);

        }

        public void dados_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }
    }
}
