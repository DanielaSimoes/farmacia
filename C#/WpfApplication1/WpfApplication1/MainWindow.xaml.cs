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

namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
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

            if (selectedText.Equals("Ver Dados do Utente"))
            {
                dadosUtente dadosUtente_frame = new dadosUtente();
                this.NavigateTo(dadosUtente_frame);
            }
            Console.WriteLine(selectedText);

            if (selectedText.Equals("Lista de Contactos de Fornecedores"))
            {
                listaFornecedores listaFornecedores_frame = new listaFornecedores();
                this.NavigateTo(listaFornecedores_frame);
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

            if (selectedText.Equals("Adicionar Pessoa"))
            {
                criar criar_frame = new criar();
                this.NavigateTo(criar_frame);
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
    }
}
