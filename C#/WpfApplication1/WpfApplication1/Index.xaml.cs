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

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for produtos.xaml
    /// </summary>
    public partial class Index : Page
    {
        public Index()
        {
            InitializeComponent(); // http://stackoverflow.com/questions/6925584/the-name-initializecomponent-does-not-exist-in-the-current-context
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

        }

        private void DEL_Click(object sender, RoutedEventArgs e)
        {
            SeeNIF.Text = SeeNIF.Text.Substring(0, SeeNIF.Text.Length - 1);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
