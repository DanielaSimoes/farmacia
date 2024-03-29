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
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using System.Windows.Forms;

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for UserForm.xaml
    /// </summary>
    public partial class UserForm : Window
    {
        private static Index idx_page;
        private SqlConnection con;

        public UserForm()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        public UserForm(DataTable dt, DataTable dt_pres, Index idx)
        {
            InitializeComponent();
            DataRow dr = dt.Rows[0];
            name.Content = (string)dr["Name"];
            nif.Content = (int)dr["NIF"];
            userNumber.Content = (int)dr["Utente Number"];
            prescriptions.ItemsSource = dt_pres.DefaultView;
            idx_page = idx;
            con = ConnectionDB.getConnection();
        }

        private void selected_btn_Click(object sender, RoutedEventArgs e)
        {
            DataRowView selectedItem = (DataRowView)prescriptions.SelectedItem;
            int item_code;

            try
            {
                item_code = (int)selectedItem.Row.ItemArray[0];
            }
            catch (Exception)
            {
                System.Windows.Forms.MessageBox.Show("Select one prescription!");
                return;
            }

            // listar medicamentos por numero perscricao
            string CmdString = "SELECT * FROM db.udf_pres_med_por_vender(@num_prescricao)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            cmd.Parameters.AddWithValue("@num_prescricao", item_code);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
                
            DateTime expires_at = (DateTime)selectedItem.Row.ItemArray[3];
            DateTime thisDay = DateTime.Today;
            int result = DateTime.Compare(expires_at, thisDay);
            if (result < 0)
            {
                System.Windows.MessageBox.Show("The prescription has expired!");
                return; 
            }

            sda.Fill(idx_page.dt_grid_produtos);
            idx_page.produtosGrid.ItemsSource = idx_page.dt_grid_produtos.DefaultView;

            int soma = 0;
            for (int i = idx_page.dt_grid_produtos.Rows.Count - 1; i >= 0; i--)
            {
                DataRow dr = idx_page.dt_grid_produtos.Rows[i];
                int price = (int)dr["Price"];
                price = price * (int)dr["Qty"];

                if((int)dr["Qty"]>1){
                    int b = 1;

                    for (; b < (int)dr["Qty"]; b++)
                    {
                        DataRow toInsert = idx_page.dt_grid_produtos.NewRow();
                        toInsert.ItemArray = dr.ItemArray.Clone() as object[];
                        toInsert["Qty"] = 1;
                        idx_page.dt_grid_produtos.Rows.InsertAt(toInsert, idx_page.dt_grid_produtos.Rows.Count);
                    }

                    dr["Qty"] = 1;
                }

                soma += price;
            }

            idx_page.show_price.Text = soma.ToString() + "€";

            this.Close();
        }
    }
}
