using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace FinalProject_v1
{
    public partial class Form2 : Form
    {
        Form1 Form;
        StreamReader reader;
        StreamWriter writer;
        FileInfo fin;
        String content;
        String[] contents;
        String[] form1_contents;
        String[] temp;
        String[,] upload;
        bool skip_yn = false;
        bool false_only;
        bool went_wrong;
        int nonyn;
        int number_of_error;
        int number = 1;
        int number_of_contents = 0;
        int total_contents = 0;
        int saved_number_of_contents;
        TextBox[] txtb = new TextBox[1];
        Button[] btn = new Button[1];
        public Form2(Form1 form, bool yn)
        {
            InitializeComponent();
            txtb[0] = textBox1;
            btn[0] = button1;
            btn[0].Name = "1";
            Form = form;
            skip_yn = yn;
        }

        private void Add_Click(object sender, EventArgs e)
        {
            number++;
            this.Size = new Size(400, 150 + 50 * number);
            Add.Location = new Point(345, 70 + 50 * number);
            Array.Resize(ref txtb, number);
            txtb[number - 1] = new TextBox()
            {
                Size = new Size(250, 29),
                Location = new Point(30, 25 + 50 * number),
                Font = new Font("微軟正黑體", 12),
                Name = "a" + number
            };
            txtb[number - 1].TextChanged += new EventHandler(Detect_Text);
            this.Controls.Add(txtb[number - 1]);
            Array.Resize(ref btn, number);
            btn[number - 1] = new Button()
            {
                Size = new Size(30, 30),
                Location = new Point(300, 25 + 50 * number),
                Text = "..",
                Font = new Font("微軟正黑體", 12),
                Name = "" + number
            };
            btn[number - 1].Click += new EventHandler(Button_Click);
            this.Controls.Add(btn[number - 1]);
        }
        private void Button_Click(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = "project question files (*.FinalProject)|*.FinalProject|txt files (*.txt)|*.txt|All files (*.*)|*.*";
            DialogResult result = ofd.ShowDialog();
            if (result == DialogResult.OK)
            {
                txtb[int.Parse(b.Name) - 1].Text = ofd.FileName;
            }
        }
        private void Open(int x)
        {
            int saved_number_of_contents = number_of_contents;
            number_of_error = 0;
            went_wrong = false;
            nonyn = 0;
            int n = 0;
            reader = new StreamReader(txtb[x].Text);
            content = reader.ReadToEnd();
            contents = content.Split('\n');
            for (int i = 0; i < contents.Length; i++)
                form1_contents[number_of_contents + i] = contents[i];
            for (int i = 0; i < contents.Length; i++)
            {
                temp = contents[i].Split('　');
                try
                {
                    if (int.Parse(temp[1]) < 0 || int.Parse(temp[1]) > 3)
                        went_wrong = true;
                    if (temp[0] == "+")
                    {
                        for (int j = 2; j < 7; j++)
                            if (j >= 2 && j <= 6 && (temp[j] == "\r" || temp[j] == ""))
                            {
                                went_wrong = true;
                            }
                        if (temp[7] != "" && temp[7] != "\r" && (int.Parse(temp[7]) < 0 || int.Parse(temp[7]) > 3))
                            went_wrong = true;
                    }
                    else if (temp[0] == "-")
                    {
                        if (temp[2] == "\r" || temp[2] == "")
                        {
                            went_wrong = true;
                        }
                        if (temp[3] != "" && temp[3] != "\r" && (int.Parse(temp[3]) < 0 || int.Parse(temp[3]) > 3))
                            went_wrong = true;
                    }
                    else
                        went_wrong = true;
                }
                catch
                {
                    went_wrong = true;
                }
                if (went_wrong)
                {
                    number_of_error++;
                    DialogResult messageboxresult = MessageBox.Show("第 " + (number_of_error + i) + " 行發生錯誤，是否繼續？", "發生錯誤！", MessageBoxButtons.YesNo, MessageBoxIcon.Error);
                    if (messageboxresult == DialogResult.Yes)
                    {
                        went_wrong = false;
                        for (int j = i; j < contents.Length - 1; j++)
                        {
                            contents[j] = contents[j + 1];
                        }
                        Array.Resize(ref contents, contents.Length - 1);
                        Array.Resize(ref form1_contents, form1_contents.Length - 1);
                        i--;
                        continue;
                    }
                    else
                    {
                        Array.Resize(ref form1_contents, form1_contents.Length - contents.Length);
                        number_of_contents = saved_number_of_contents;
                        break;
                    }
                }
                if (temp[0] == "+")
                {
                    upload[n, 7] = "";
                    if (temp[7] != "" && temp[7] != "\r")
                    {
                        if (false_only && temp[1] == temp[7])
                            continue;
                        upload[n, 7] = temp[7];
                    }
                    else if (false_only && temp[7] == "")
                    {
                        continue;
                    }
                    nonyn++;
                    for (int j = 0; j < 7; j++)
                        upload[n, j] = temp[j];
                    n++;
                }
                else if (temp[0] == "-")
                {
                    upload[n, 7] = "";
                    if (temp[3] != "" && temp[3] != "\r")
                    {
                        if (false_only && temp[1] == temp[3])
                            continue;
                        upload[n, 7] = temp[3];
                    }
                    else if (false_only && temp[3] == "" && temp[3] != "\r")
                    {
                        continue;
                    }
                    for (int j = 0; j < 3; j++)
                        upload[n, j] = temp[j];
                    n++;
                }
                number_of_contents++;
            }
            reader.Close();
            if (contents.Length == 0)
                MessageBox.Show("錯誤，此檔案無法讀取", "檔案讀取失敗", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
        private void Detect_Text(object sender, EventArgs e)
        {
            TextBox b = (TextBox)sender;
            bool error = false;
            for (int i = 0; i < number; i++)
            {
                if (b.Name == txtb[i].Name)
                    continue;
                if (b.Text == txtb[i].Text && b.Text != "")
                    error = true;
            }
            if (error)
            {
                DialogResult dr = MessageBox.Show("檔案重複！是否繼續載入", "檔案重複", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                if (dr == DialogResult.No)
                {
                    b.Text = "";
                    MessageBox.Show("欄位已清空", "清空欄位", MessageBoxButtons.OK, MessageBoxIcon.None);
                }
            }
        }

        private void Upload_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < number; i++)
            {
                try
                {
                    reader = new StreamReader(txtb[i].Text);
                    String str = reader.ReadToEnd();
                    contents = str.Split('\n');
                    total_contents += contents.Length;
                } catch
                {
                    MessageBox.Show("第 " + (i + 1) + "份檔案不存在或檔名為空", "檔案不存在", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            form1_contents = new String[total_contents];
            upload = new String[total_contents, 8];
            for (int i = 0; i < number; i++)
            {
                if (txtb[i].Text != "")
                {
                    File.Text = "目前檔案：" + txtb[i].Text;
                    Open(i);
                }
            }
            if (number_of_contents != 0)
            {
                Form.questions_and_answers = upload;
                Form.nonyn = nonyn;
                Form.contents = form1_contents;
                this.Close();
            }
        }
    }
}
