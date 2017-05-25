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
using System.Data;
using System.Data.SqlClient;

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for Page1.xaml
    /// </summary>
    public partial class criarMedicamento : Page
    {
        private SqlConnection con;

        public criarMedicamento()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            int idLab_int, codigo_int, quantidade_int, categoria_int, tipo_int, dose_int, uni_int, pvp_int, price_int, iva_int;

           
            string CmdString = "db.sp_createMedicamento";
            SqlCommand cmd_member = new SqlCommand(CmdString, con);
            cmd_member.CommandType = CommandType.StoredProcedure;
            

            try
            {
                cmd_member.Parameters.AddWithValue("@nome", nome.Text);
            }
            catch (Exception)
            {
            }

            try
            {
                if (Int32.TryParse(ID_lab.Text, out idLab_int))
                {
                    cmd_member.Parameters.AddWithValue("@lab_id", idLab_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The Lab ID must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(codigo.Text, out codigo_int))
                {
                    cmd_member.Parameters.AddWithValue("@codigo", codigo_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The code must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(categoria.Text, out categoria_int))
                {
                    cmd_member.Parameters.AddWithValue("@categoria_id", categoria_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The category ID must be an Integer!");
                return;
            }


            try
            {
                if (Int32.TryParse(tipo.Text, out tipo_int))
                {
                    cmd_member.Parameters.AddWithValue("@tipo_id", tipo_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The type ID must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(quantidade.Text, out quantidade_int))
                {
                    cmd_member.Parameters.AddWithValue("@quantidade", quantidade_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The amount must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(dose.Text, out dose_int))
                {
                    cmd_member.Parameters.AddWithValue("@dose", dose_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The dosage must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(unidades.Text, out uni_int))
                {
                    cmd_member.Parameters.AddWithValue("@unidades", uni_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The units must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(pvp.Text, out pvp_int))
                {
                    cmd_member.Parameters.AddWithValue("@PVP", pvp_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The PVP must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(price.Text, out price_int))
                {
                    cmd_member.Parameters.AddWithValue("@preco", price_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The price must be an Integer!");
                return;
            }

            try
            {
                if (Int32.TryParse(IVA.Text, out iva_int))
                {
                    cmd_member.Parameters.AddWithValue("@IVA", iva_int);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("The IVA must be an Integer!");
                return;
            }

            
            DateTime dt;
             try
            {
                if (DateTime.TryParse(data.Text, out dt))
                {
                    
                    cmd_member.Parameters.AddWithValue("@validade", dt);
                }
            }
            
            catch (Exception)
            {
                MessageBox.Show("Please insert a valid date!");
                return;
            }

            try
            {
                con.Open();
                cmd_member.ExecuteNonQuery();
                MessageBox.Show("Medication Added!");
                con.Close();
            }
            catch (Exception exc)
            {
                con.Close();
                MessageBox.Show(exc.Message);
            }
            
        }
    }
}
