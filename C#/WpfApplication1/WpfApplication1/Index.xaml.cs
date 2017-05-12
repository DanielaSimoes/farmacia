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
        DataTable dt_grid_produtos = new DataTable("meds");

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

            }

            LabelNIF_Bool = !LabelNIF_Bool;
            if (LabelNIF_Bool)
            {
                LabelNIF.Content = "NIF";
            }

        }

        private void DEL_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.Text = SeeNIF.Text.Substring(0, SeeNIF.Text.Length - 1);
        }

        private void DelRow_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                DataRowView selectedItem = (DataRowView)produtosGrid.SelectedItem;
                int item_code = (int)selectedItem.Row.ItemArray[8];
                if (item_code != null)
                {
                    for(int i = dt_grid_produtos.Rows.Count-1; i >= 0; i--)
                    {
                        DataRow dr = dt_grid_produtos.Rows[i];
                        int dr_code = (int)dr["Code"];
                        if (dr_code == item_code)
                        {
                            dr.Delete();
                        }
                    }
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

        private void OK_Click(object sender, TextChangedEventArgs e)
        {

        }

        private void SeeNIF_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void pay(object sender, RoutedEventArgs e)
        {
            // aqui tem que ir buscar todos os produtos que estão na grid e subtrair ao stock através de uma store procedure
                produtosGrid.SelectAll();

                DataRowView selectedItems = (DataRowView)produtosGrid.SelectedItems;
                int item_code = (int)selectedItems.Row.ItemArray[8];
                int item_quantidade = (int)selectedItems.Row.ItemArray[2];
                    for (int i = dt_grid_produtos.Rows.Count - 1; i >= 0; i--)
                    {
                        DataRow dr = dt_grid_produtos.Rows[i];
                        int dr_code = (int)dr["Code"];
                        if (dr_code == item_code)
                        {
                            //Atualizar o stock
                            string CmdString = "db.sp_modifyMedicamento";
                            SqlCommand cmd_member = new SqlCommand(CmdString, con);
                            cmd_member.CommandType = CommandType.StoredProcedure;
                            cmd_member.Parameters.AddWithValue("@quantidade", item_quantidade - 1);

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
                    }

            //Apagar todos o items da lista
                for (int i = dt_grid_produtos.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt_grid_produtos.Rows[i];
                    int dr_code = (int)dr["Code"];
                    dr.Delete();
                }
        }
    }
}
