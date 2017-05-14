﻿using System;
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
    /// Interaction logic for produtos.xaml
    /// </summary>
    public partial class Index : Page
    {
        bool LabelNIF_Bool = true;
        private SqlConnection con;
        SqlCommand cmd;
        public DataTable dt_grid_produtos = new DataTable("meds");
        DataTable dt = new DataTable("person");
        SqlDataAdapter sda;
        int NIFInt;

        public Index()
        {
            InitializeComponent(); // http://stackoverflow.com/questions/6925584/the-name-initializecomponent-does-not-exist-in-the-current-context
            con = ConnectionDB.getConnection();
        }


        private void FillGridProdutos(int codigo)
        {
            string CmdString = "SELECT * FROM db.udf_stock_data_grid(DEFAULT, @codigo)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            cmd.Parameters.AddWithValue("@codigo", codigo);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt_grid_produtos);
            produtosGrid.ItemsSource = dt_grid_produtos.DefaultView;

            if (codigo == null){
                MessageBox.Show("The code does not exist!");
            }
        }

        private void T0_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("0");
        }

        private void T1_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("1");
        }

        private void T2_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("2");
        }

        private void T3_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("3");
        }

        private void T4_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("4");
        }

        private void T5_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("5");
        }

        private void T6_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("6");
        }

        private void T7_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("7");
        }

        private void T8_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("8");
        }

        private void T9_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.AppendText("9");
        }

        private void OK_Click(object sender, RoutedEventArgs e)
        {
            if (LabelNIF_Bool)
            {
                // é para adicionar o NIF

                if (!Int32.TryParse(SeeNIF.Text, out NIFInt))
                {
                    MessageBox.Show("The NIF must be an Integer!");
                    return;
                }

                try
                {
                    string CmdString = "SELECT * FROM db.utente_data_grid(@nif)";
                    cmd = new SqlCommand(CmdString, con);
                    sda = new SqlDataAdapter(cmd);
                    cmd.Parameters.AddWithValue("@nif", NIFInt);
                    DataTable dt = new DataTable("person");
                    sda.Fill(dt);
                    if (dt.Rows.Count == 0)
                    {
                        MessageBox.Show("NIF not found!");
                        criarUtente utente = new criarUtente();
                        this.NavigationService.Navigate(utente);
                        
                    }
                    else
                    {

                        // search for prescriptions
                        CmdString = "SELECT * FROM db.udf_prescricao_data_grid(@utente_NIF)";
                        cmd = new SqlCommand(CmdString, con);
                        sda = new SqlDataAdapter(cmd);
                        cmd.Parameters.AddWithValue("@utente_NIF", NIFInt);
                        DataTable dt_pres = new DataTable("prescriptions");
                        sda.Fill(dt_pres);

                        UserForm uf = new UserForm(dt, dt_pres, this);
                        uf.Show();

                        
                       
                    }
                }
                catch (Exception exc)
                {
                    MessageBox.Show(exc.Message);
                }
            }
            else { 
                // é para procurar pelo produto
                int cod;
                if (!Int32.TryParse(SeeNIF.Text, out cod))
                {
                    MessageBox.Show("The code must be an Integer!");
                    return;
                }

                FillGridProdutos(cod);
                LabelNIF_Bool = !LabelNIF_Bool;
                LabelNIF.Content = "NIF";

            }


        }

        private void DEL_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SeeNIF.Text = SeeNIF.Text.Substring(0, SeeNIF.Text.Length - 1);
            }
            catch (Exception) { }
        }

        private void DelRow_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int selectedItem = produtosGrid.SelectedIndex;

                if (selectedItem != null)
                {
                    dt_grid_produtos.Rows.RemoveAt(selectedItem);
                }
                produtosGrid.ItemsSource = dt_grid_produtos.DefaultView;
            }
            catch (Exception)
            {

            }
        }

        private void Codigo(object sender, RoutedEventArgs e)
        {
            LabelNIF_Bool = !LabelNIF_Bool;
            if (!LabelNIF_Bool)
            {
                LabelNIF.Content = "Código";
            }
            else
            {
                LabelNIF.Content = "NIF";
            }
        }


        private void SeeNIF_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void pay(object sender, RoutedEventArgs e)
        {
            for (int i = dt_grid_produtos.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = dt_grid_produtos.Rows[i];
                int dr_code = (int)dr["Code"];

                string CmdString = "db.sp_decrementMedicamento";
                cmd = new SqlCommand(CmdString, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codigo", dr_code);
                CmdString = "db.sp_decrementMedicamento";


                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    dr.Delete();
                }
                catch (Exception exc)
                {
                    MessageBox.Show(exc.Message);
                }
            }



            MessageBox.Show("Payment completed!");
        }

        public void dados_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

    }
}
