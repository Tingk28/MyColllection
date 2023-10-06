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
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace FinalProject_v1
{
    public partial class Form1 : Form
    {
        StreamReader reader;
        StreamWriter writer;
        String content;
        public String[] contents;
        String[] temp;
        String[] answer_for_this_time;
        String[] form2_contents;
        public String[,] questions_and_answers;
        bool selected = false;
        bool skip_random = false;
        bool skip_yn = false;
        bool false_only = false;
        bool started;
        bool went_wrong;
        bool saved = false;
        int current_question;
        int number_of_nonyn;
        public int nonyn;
        int current_nonyn;
        int answered;
        int correct;
        int wrong;
        int number_of_error;
        int[] chosen;
        int[,] print_questions;
        IWebDriver driver;
        Random rnd = new Random(Guid.NewGuid().GetHashCode());
        public Form1()
        {
            InitializeComponent();
            //ChromeOptions options = new ChromeOptions();
            var chromeDriverService = ChromeDriverService.CreateDefaultService();
            chromeDriverService.HideCommandPromptWindow = true;
            driver = new ChromeDriver(chromeDriverService);
            driver.Manage().Window.Size = new Size(800, 640);
            
            driver.Url = "https://translate.google.com.tw/";
        }

        private void Open_Click(object sender, EventArgs e)// user open the file
        {
            if (started)
            {
                DialogResult dr1 = MessageBox.Show("是否關閉當前作答並讀取新題目？", "已開始作答", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (dr1 == DialogResult.Yes)
                {
                    DialogResult dr2 = MessageBox.Show("是否儲存題目？", "已開始作答", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dr2 == DialogResult.Yes)
                    {
                        save_file();
                        MessageBox.Show("已儲存題目，請選擇要開啟的檔案", "成功儲存", MessageBoxButtons.OK, MessageBoxIcon.None);
                    }
                    ButtonA.Enabled = false;
                    ButtonB.Enabled = false;
                    ButtonC.Enabled = false;
                    ButtonD.Enabled = false;
                    Redo.Enabled = false;
                    Previous.Enabled = false;
                    Next.Enabled = false;
                    Description.Text = "";
                    ChapterName.Text = "請選擇檔案";
                    Progress.Text = "進度:-/-";
                    started = false;
                    went_wrong = false;
                    selected = false;
                    number_of_error = 0;
                    nonyn = 0;
                    open();
                }
            } else
            {
                number_of_error = 0;
                nonyn = 0;
                open();
            }
        }

        private void open()
        {
            DialogResult check = MessageBox.Show("是否只讀入錯誤", "讀入錯誤", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (check == DialogResult.Yes)
                false_only = true;
            else
                false_only = false;
            OpenFileDialog ofd = new OpenFileDialog();
            DialogResult result = ofd.ShowDialog();
            ofd.Filter = "project question files (*.FinalProject)|*.FinalProject|txt files (*.txt)|*.txt|All files (*.*)|*.*";
            if (result == DialogResult.OK)
            {
                String address = ofd.FileName;
                ChapterName.Text = System.IO.Path.GetFileName(ofd.FileName);
                reader = new StreamReader(address);
                content = reader.ReadToEnd();
                contents = content.Split('\n');
                print_questions = new int[contents.Length, 5];
                chosen = new int[contents.Length];
                questions_and_answers = new String[contents.Length, 8];
                answer_for_this_time = new String[contents.Length];
                int n = 0;
                for (int i = 0; i < contents.Length; i++)
                {
                    print_questions[i, 0] = i;
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
                            i--;
                            continue;
                        }
                        else
                        {
                            break;
                        }
                    }
                    if (temp[0] == "+" && temp[7] != "\r")
                    {
                        questions_and_answers[n, 7] = "";
                        if (temp[7] != "" && temp[7] != "\r")
                        {
                            if (false_only && temp[1] == temp[7])
                                continue;
                            questions_and_answers[n, 7] = temp[7];
                        } else if (false_only && temp[7] == "")
                        {
                            continue;
                        }
                        nonyn++;
                        for (int j = 0; j < 7; j++)
                            questions_and_answers[n, j] = temp[j];
                        n++;
                    }
                    else if (temp[0] == "-")
                    {
                        questions_and_answers[n, 7] = "";
                        if (temp[3] != "" && temp[3] != "\r")
                        {
                            if (false_only && temp[1] == temp[3])
                                continue;
                            questions_and_answers[n, 7] = temp[3];
                        }
                        else if (false_only && temp[3] == "" && temp[3] != "\r")
                        {
                            continue;
                        }
                        for (int j = 0; j < 3; j++)
                            questions_and_answers[n, j] = temp[j];
                        n++;
                    }
                }
                Array.Resize(ref contents, n);
                reader.Close();
                if (contents.Length == 0)
                    MessageBox.Show("錯誤，此檔案無法讀取", "檔案讀取失敗", MessageBoxButtons.OK, MessageBoxIcon.Error);
                else
                {
                    ChangeLO.Enabled = true;
                    selected = true;
                }
            }
            else
            {
                MessageBox.Show("請選擇檔案");
            }
        }

        private void ChangeLO_Click(object sender, EventArgs e) // start to show the question
        {
            Change();
        }

        private void Change()
        {
            if (selected)
            {
                ButtonA.Enabled = true;
                ButtonB.Enabled = true;
                ButtonC.Enabled = true;
                ButtonD.Enabled = true;
                Redo.Enabled = true;
                SaveAs.Enabled = true;
                Progress.Text = "進度:-/-";
                number_of_nonyn = nonyn;
                current_nonyn = 0;
                answered = 0;
                correct = 0;
                wrong = 0;
                if (!skip_random)
                {
                    int n = 0;
                    int m;
                    int random_number;
                    bool appeared_before;
                    for (int i = 0; i < contents.Length; i++)
                    {
                        chosen[i] = -1;
                        while (n < contents.Length)
                        {
                            random_number = rnd.Next(0, contents.Length);
                            appeared_before = false;
                            for (int j = 0; j < n; j++)
                            {
                                if (random_number == print_questions[j, 0])
                                {
                                    appeared_before = true;
                                    break;
                                }
                            }
                            if (!appeared_before)
                            {
                                print_questions[n, 0] = random_number;
                                m = 0;
                                if (questions_and_answers[print_questions[n, 0], 0] == "+")
                                {
                                    while (m < 4)
                                    {
                                        random_number = rnd.Next(0, 4);
                                        appeared_before = false;
                                        for (int j = 1; j < 1 + m; j++)
                                        {
                                            if (random_number == print_questions[n, j])
                                            {
                                                appeared_before = true;
                                                break;
                                            }
                                        }
                                        if (!appeared_before)
                                        {
                                            m++;
                                            print_questions[n, m] = random_number;
                                        }
                                    }
                                }
                                else
                                {
                                    print_questions[n, 1] = 0;
                                    print_questions[n, 2] = 1;
                                }
                                n++;
                            }
                        }
                    }
                }
                else
                {
                    for (int i = 0; i < contents.Length; i++)
                    {
                        chosen[i] = -1;
                        print_questions[i, 0] = i;
                        if (questions_and_answers[i, 0] == "+")
                        {
                            for (int j = 0; j < 4; j++)
                            {
                                print_questions[i, j + 1] = j;
                            }
                        }
                    }
                }
                current_question = 0;
                if (skip_yn && questions_and_answers[print_questions[current_question, 0], 0] == "-")
                {
                    do
                    {
                        current_question++;
                    } while (current_question < contents.Length && questions_and_answers[print_questions[current_question, 0], 0] == "-");
                }
                Rearrange();
            }
        }

        private void Next_Click(object sender, EventArgs e)//next question
        {
            current_question++;
            while (true)
                if (skip_yn && questions_and_answers[print_questions[current_question, 0], 0] == "-")
                {
                    current_question++;
                }
                else
                {
                    current_nonyn++;
                    break;
                }
            Rearrange();
        }


        private void Previous_Click(object sender, EventArgs e)//previous question
        {
            current_question--;
            while (true)
                if (skip_yn && questions_and_answers[print_questions[current_question, 0], 0] == "-")
                {
                    current_question--;
                }
                else
                {
                    current_nonyn--;
                    break;
                }
            Rearrange();
        }
        private void Rearrange()
        {
            started = true;
            ButtonA.Enabled = true;
            ButtonB.Enabled = true;
            ButtonC.Enabled = true;
            ButtonD.Enabled = true;
            Description.Text = questions_and_answers[print_questions[current_question, 0], 2] + "\r\n";
            if (questions_and_answers[print_questions[current_question, 0], 0] == "-")
            {
                ButtonC.Visible = false;
                ButtonD.Visible = false;
                ButtonC.Enabled = false;
                ButtonD.Enabled = false;
                ButtonA.Text = "F";
                ButtonB.Text = "T";
            }
            else
            {
                Description.Text += "\r\n A: " + questions_and_answers[print_questions[current_question, 0], print_questions[current_question, 1] + 3] + "\r\n";
                Description.Text += " B: " + questions_and_answers[print_questions[current_question, 0], print_questions[current_question, 2] + 3] + "\r\n";
                Description.Text += " C: " + questions_and_answers[print_questions[current_question, 0], print_questions[current_question, 3] + 3] + "\r\n";
                Description.Text += " D: " + questions_and_answers[print_questions[current_question, 0], print_questions[current_question, 4] + 3] + "\r\n";
                ButtonC.Visible = true;
                ButtonD.Visible = true;
                ButtonC.Enabled = true;
                ButtonD.Enabled = true;
                ButtonA.Text = "A";
                ButtonB.Text = "B";
            }
            if (current_question == contents.Length - 1 || (skip_yn && current_nonyn + 1 == number_of_nonyn))// is the last one
            {
                Next.Enabled = false;
            }
            else
            {
                Next.Enabled = true;
            }
            if (current_question == 0 || (skip_yn && current_nonyn == 0)) // first question
            {
                Previous.Enabled = false;
            }
            else
            {
                Previous.Enabled = true;
            }
            // reset button color
            ButtonA.BackColor = Color.LightGray;
            ButtonB.BackColor = Color.LightGray;
            ButtonC.BackColor = Color.LightGray;
            ButtonD.BackColor = Color.LightGray;
            // decide the button color
            if (chosen[current_question] == 0)
            {
                Judge(ButtonA);
                ButtonA.Enabled = false;
                ButtonB.Enabled = false;
                ButtonC.Enabled = false;
                ButtonD.Enabled = false;
            } else if (chosen[current_question] == 1)
            {
                Judge(ButtonB);
                ButtonA.Enabled = false;
                ButtonB.Enabled = false;
                ButtonC.Enabled = false;
                ButtonD.Enabled = false;
            } else if (chosen[current_question] == 2)
            {
                Judge(ButtonC);
                ButtonA.Enabled = false;
                ButtonB.Enabled = false;
                ButtonC.Enabled = false;
                ButtonD.Enabled = false;
            } else if (chosen[current_question] == 3)
            {
                Judge(ButtonD);
                ButtonA.Enabled = false;
                ButtonB.Enabled = false;
                ButtonC.Enabled = false;
                ButtonD.Enabled = false;
            }
            if (questions_and_answers[print_questions[current_question, 0], 7] != "\r" && questions_and_answers[print_questions[current_question, 0], 7] != "")
                Show__Previous.Enabled = true;
            else
                Show__Previous.Enabled = false;
        }

        private void ButtonA_Click(object sender, EventArgs e)
        {
            answered++;
            chosen[current_question] = 0;
            ButtonA.Enabled = false;
            ButtonB.Enabled = false;
            ButtonC.Enabled = false;
            ButtonD.Enabled = false;
            Judge(ButtonA);
        }

        private void ButtonB_Click(object sender, EventArgs e)
        {
            answered++;
            chosen[current_question] = 1;
            ButtonA.Enabled = false;
            ButtonB.Enabled = false;
            ButtonC.Enabled = false;
            ButtonD.Enabled = false;
            Judge(ButtonB);
        }

        private void ButtonC_Click(object sender, EventArgs e)
        {
            answered++;
            chosen[current_question] = 2;
            ButtonA.Enabled = false;
            ButtonB.Enabled = false;
            ButtonC.Enabled = false;
            ButtonD.Enabled = false;
            Judge(ButtonC);
        }

        private void ButtonD_Click(object sender, EventArgs e)
        {
            answered++;
            chosen[current_question] = 3;
            ButtonA.Enabled = false;
            ButtonB.Enabled = false;
            ButtonC.Enabled = false;
            ButtonD.Enabled = false;
            Judge(ButtonD);
        }
        private void Judge(Button n)
        {
            if (questions_and_answers[print_questions[current_question, 0], 0] == "-")
            {
                YesNo(n);
            } else
            {
                answer_for_this_time[print_questions[current_question, 0]] = "" + print_questions[current_question, chosen[current_question] + 1];
                if (int.Parse(questions_and_answers[print_questions[current_question, 0], 1]) == print_questions[current_question, 1 + n.Text.ElementAt(0) - 'A'])
                {
                    n.BackColor = Color.Green;
                    correct++;
                }
                else
                {
                    wrong++;
                    if (int.Parse(questions_and_answers[print_questions[current_question, 0], 1]) == print_questions[current_question, 1])
                    {
                        ButtonA.BackColor = Color.Green;
                    }
                    else if (int.Parse(questions_and_answers[print_questions[current_question, 0], 1]) == print_questions[current_question, 2])
                    {
                        ButtonB.BackColor = Color.Green;
                    }
                    else if (int.Parse(questions_and_answers[print_questions[current_question, 0], 1]) == print_questions[current_question, 3])
                    {
                        ButtonC.BackColor = Color.Green;
                    }
                    else if (int.Parse(questions_and_answers[print_questions[current_question, 0], 1]) == print_questions[current_question, 4])
                    {
                        ButtonD.BackColor = Color.Green;
                    }
                    n.BackColor = Color.Red;
                }
            }
            if (skip_yn)
                Progress.Text = "進度: " + answered + " / " + number_of_nonyn;
            else
                Progress.Text = "進度: " + answered + " / " + contents.Length;
            CorrectWrong.Text = "correct: " + correct + " / wrong: " + wrong;
        }
        private void YesNo(Button btn)
        {
            bool y = false;
            answer_for_this_time[print_questions[current_question, 0]] = "0";
            if (btn.Text == "T")
            {
                y = true;
                answer_for_this_time[print_questions[current_question, 0]] = "1";
            }
            if ((y && questions_and_answers[print_questions[current_question, 0], 1] == "1") || (!y && questions_and_answers[print_questions[current_question, 0], 1] == "0"))
            {
                btn.BackColor = Color.Green;
                correct++;
            } else
            {
                wrong++;
                btn.BackColor = Color.Red;
                if (btn.Text == "F")
                {
                    ButtonB.BackColor = Color.Green;
                } else
                {
                    ButtonA.BackColor = Color.Green;
                }
            }
        }

        private void Redo_Click(object sender, EventArgs e)
        {
            int m = 0;
            int random_number;
            bool appeared_before;
            if (chosen[current_question] != -1)
            {
                answered--;
                if (print_questions[current_question, chosen[current_question] + 1] == int.Parse(questions_and_answers[print_questions[current_question, 0], 1]))
                    correct--;
                else
                    wrong--;
            }
            chosen[current_question] = -1;
            if (!skip_random)
            {
                if (questions_and_answers[print_questions[current_question, 0], 0] == "+")
                {
                    while (m < 4)
                    {
                        random_number = rnd.Next(0, 4);
                        appeared_before = false;
                        for (int j = 1; j < 1 + m; j++)
                        {
                            if (random_number == print_questions[current_question, j])
                            {
                                appeared_before = true;
                                break;
                            }
                        }
                        if (!appeared_before)
                        {
                            m++;
                            print_questions[current_question, m] = random_number;
                        }
                    }
                }
            }
            if (answered == 0)
                Progress.Text = "進度:-/-";
            else if (skip_yn)
                Progress.Text = "進度: " + answered + " / " + number_of_nonyn;
            else
                Progress.Text = "進度: " + answered + " / " + contents.Length;
            CorrectWrong.Text = "correct: " + correct + " / wrong: " + wrong;
            Rearrange();
        }

        private void SaveAs_Click(object sender, EventArgs e)
        {
            save_file();
        }

        private void save_file()
        {
            SaveFileDialog sfd = new SaveFileDialog();
            sfd.Filter = "project question files (*.FinalProject)|*.FinalProject|All files (*.*)|*.*";
            DialogResult result = sfd.ShowDialog();
            if (result == DialogResult.OK)
            {
                String address = sfd.FileName;
                writer = new StreamWriter(address);
                for (int i = 0; i < contents.Length; i++)
                {
                    if (questions_and_answers[i, 0] == "-")
                    {
                        for (int j = 0; j < 3; j++)
                        {
                            writer.Write(questions_and_answers[i, j]);
                            writer.Write("　");
                        }
                    }
                    else
                    {
                        for (int j = 0; j < 7; j++)
                        {
                            writer.Write(questions_and_answers[i, j]);
                            writer.Write("　");
                        }
                    }

                    if (answer_for_this_time[i] != "" && answer_for_this_time[i] != "\n")
                        writer.Write(answer_for_this_time[i]);
                    if (i + 1 < contents.Length)
                        writer.Write("\n");
                }
                writer.Flush();
                writer.Close();
                if (saved)
                {
                    MessageBox.Show("已儲存題目，請選擇要開啟的檔案", "成功儲存", MessageBoxButtons.OK, MessageBoxIcon.None);
                    saved = false;
                }
            }
        }

        private void 設定字型ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FontDialog fontDialog1 = new FontDialog();

            if (fontDialog1.ShowDialog() == DialogResult.OK)
            {
                Description.Font = fontDialog1.Font;
            }
        }

        private void Info_Click(object sender, EventArgs e)
        {
            MessageBox.Show("視窗程式設計 Final project\n主題：（數位學習）刷選擇題工具\n作者：王偉同、郭庭維","關於");
        }

        private void SkipYesNo_CheckedChanged(object sender, EventArgs e)
        {
            skip_yn = !skip_yn;
            Change();
        }

        private void SkipRandom_CheckedChanged(object sender, EventArgs e)
        {
            skip_random = !skip_random;
        }

        private void Show__Previous_Click(object sender, EventArgs e)
        {
            if (questions_and_answers[print_questions[current_question, 0], 0] == "+")
            {
                MessageBox.Show("上次答案為: " + questions_and_answers[print_questions[current_question, 0], int.Parse(questions_and_answers[print_questions[current_question, 0], 7]) + 3], "顯示上次答案", MessageBoxButtons.OK);
            }
            else if (int.Parse(questions_and_answers[print_questions[current_question, 0], 7]) == 1)
            {
                MessageBox.Show("上次答案為: True", "顯示上次答案", MessageBoxButtons.OK);
            }
            else
            {
                MessageBox.Show("上次答案為: False", "顯示上次答案", MessageBoxButtons.OK);
            }
        }


        private void Translate_Click(object sender, EventArgs e)
        {
            try
            {
                driver.FindElement(By.TagName("textarea")).Clear();
                driver.FindElement(By.TagName("textarea")).SendKeys(Description.Text);
            } catch
            {
                translate.Enabled = false;
            }
            //driver.find_element(By.TAG_NAME, "textarea").send_keys(string.replace('\t', ' ').replace('\n\n', '\n'))
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {
            driver.Quit();
        }

        private void openFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (started)
            {
                DialogResult dr1 = MessageBox.Show("是否關閉當前作答並讀取新題目？", "已開始作答", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (dr1 == DialogResult.Yes)
                {
                    DialogResult dr2 = MessageBox.Show("是否儲存題目？", "已開始作答", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dr2 == DialogResult.Yes)
                    {
                        saved = true;
                        save_file();
                    }
                    questions_and_answers = null;
                    contents = null;
                    ButtonA.Enabled = false;
                    ButtonB.Enabled = false;
                    ButtonC.Enabled = false;
                    ButtonD.Enabled = false;
                    Redo.Enabled = false;
                    Previous.Enabled = false;
                    Next.Enabled = false;
                    started = false;
                    Description.Text = "";
                    ChapterName.Text = "請選擇檔案";
                    Progress.Text = "進度:-/-";
                    Form2 form = new Form2(this, skip_yn);
                    form.ShowDialog();
                    if (contents != null && contents.Length != 0)
                    {
                        number_of_error = 0;
                        ChapterName.Text = "合併輸入題庫";
                        went_wrong = false;
                        ChangeLO.Enabled = true;
                        print_questions = new int[contents.Length, 5];
                        chosen = new int[contents.Length];
                        answer_for_this_time = new String[contents.Length];
                    }
                    else
                    {
                        selected = false;
                        MessageBox.Show("請選擇檔案");
                    }
                }
            }
            else
            {
                Form2 form = new Form2(this, skip_yn);
                form.ShowDialog();
                if (contents != null && contents.Length != 0)
                {
                    ChapterName.Text = "合併輸入題庫";
                    selected = true;
                    ChangeLO.Enabled = true;
                    print_questions = new int[contents.Length, 5];
                    chosen = new int[contents.Length];
                    answer_for_this_time = new String[contents.Length];
                }
                else
                    MessageBox.Show("請選擇檔案");
            }
        }
    }
}
