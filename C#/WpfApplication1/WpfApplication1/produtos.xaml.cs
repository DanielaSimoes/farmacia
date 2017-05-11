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
    /// Interaction logic for produtos.xaml
    /// </summary>
    public partial class produtos : Page
    {
        private SqlConnection con;

        public produtos()
        {
            InitializeComponent(); // http://stackoverflow.com/questions/6925584/the-name-initializecomponent-does-not-exist-in-the-current-context
            con = ConnectionDB.getConnection();
            FillProdutos();
        }

        private void FillProdutos()
        {
            /*
            string CmdString = "SELECT nome AS Nome, quantidade as Quantidade, dose as Dose, unidades as Unidades FROM db.Medicamento;";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("produtos");
            sda.Fill(dt);
            produtosGrid.ItemsSource = dt.DefaultView;

             */ 
        }

        private void InsertProduto()
        {   
            // INSERT MEDICAMENTO
            DateTime dt;
            if (!DateTime.TryParse("20/01/2018", out dt))
            {
                MessageBox.Show("Please insert a valid date!");
                return;
            }

            string CmdString = "db.sp_createMedicamento";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@nome", "Medicamento nome");
            cmd.Parameters.AddWithValue("@lab_id", 1);
            cmd.Parameters.AddWithValue("@quantidade", 2);
            cmd.Parameters.AddWithValue("@validade", dt);
            cmd.Parameters.AddWithValue("@dose", 2);
            cmd.Parameters.AddWithValue("@unidades", 2);
            cmd.Parameters.AddWithValue("@categoria_id", 2);
            cmd.Parameters.AddWithValue("@tipo_id", 2);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                MessageBox.Show("O medicamento foi inserido com sucesso!");
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
            }  
    }

        private void select_from_udf_example(){
            /*
            string CmdString = "SELECT * FROM football.udf_players_data_grid(DEFAULT)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable("players");
            sda.Fill(dt);
            playersGrid.ItemsSource = dt.DefaultView;

            // fill the teams of the player
            CmdString = "SELECT * FROM football.udf_team_names()";
            cmd = new SqlCommand(CmdString, con);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable("teams");
            sda.Fill(dt);

            playerTeams.Items.Clear();
            foreach (DataRow team in dt.Rows)
            {
                ListBoxItem itm = new ListBoxItem();
                itm.Content = team[0].ToString();
                playerTeams.Items.Add(itm);
            }
             * */
        }
}
