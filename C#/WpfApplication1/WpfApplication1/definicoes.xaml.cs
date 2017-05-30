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
    public partial class definicoes : Page
    {
        private SqlConnection con;
        DataTable dt1;

        public definicoes()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        public definicoes(DataTable dt)
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
            dt1 = dt;
        }


        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int inicio_int, fim_int;

            if (!Int32.TryParse(inicio.Text, out inicio_int))
            {
                MessageBox.Show("The begin must be an Integer!");
                return;
            }

            if (!Int32.TryParse(fim.Text, out fim_int))
            {
                MessageBox.Show("The end must be an Integer!");
                return;
            }

            string CmdString = "db.sp_createPeriodo";
            SqlCommand cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;
            cmd_member.Parameters.AddWithValue("@inicio", inicio_int);
            cmd_member.Parameters.AddWithValue("@fim", fim_int);
            cmd_member.Parameters.AddWithValue("@dia_da_semana", dia.Text);
         
            try
            {
                con.Open();
                cmd_member.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception exc)
            {
                con.Close();
                MessageBox.Show(exc.Message);
            }

            CmdString = "db.sp_createDisponibilidade";
            cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;
            cmd_member.Parameters.AddWithValue("@disponibilidade", disponibilidade.Text);

            try
            {
                con.Open();
                cmd_member.ExecuteNonQuery();
               
                con.Close();
            }
            catch (Exception exc)
            {
                con.Close();
                MessageBox.Show(exc.Message);
            }
        }

        private void Button_Click1(object sender, RoutedEventArgs e)
        {

        }

        private void menu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void Button_Click_del(object sender, RoutedEventArgs e)
        {
            string CmdString = "db.sp_delete_periodo";
            SqlCommand cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;

            String selectedItem = periods.SelectedIndex.ToString();
            DataRow dr = dt1.Rows[Int32.Parse(selectedItem)];

            cmd_member.Parameters.AddWithValue("@ID_disponibilidade", (int)dr["ID_dispo"]);
            cmd_member.Parameters.AddWithValue("@ID_periodo", (int)dr["ID_per"]);
            
            try
            {
                con.Open();
                cmd_member.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
                con.Close();
            }

            periods.Items.Remove(periods.SelectedItem);
        }
    }
}
