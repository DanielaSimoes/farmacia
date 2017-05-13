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
    /// Interaction logic for Page1.xaml
    /// </summary>
    public partial class detalhes_prescricoes : Page
    {
        private SqlConnection con;

        public detalhes_prescricoes()
        {
            InitializeComponent();
            con = ConnectionDB.getConnection();
        }


        private void historicoPrescrGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }


    }
}
