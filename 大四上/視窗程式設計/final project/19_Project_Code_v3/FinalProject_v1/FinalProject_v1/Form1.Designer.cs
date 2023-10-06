namespace FinalProject_v1
{
    partial class Form1
    {
        /// <summary>
        /// 設計工具所需的變數。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清除任何使用中的資源。
        /// </summary>
        /// <param name="disposing">如果應該處置受控資源則為 true，否則為 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 設計工具產生的程式碼

        /// <summary>
        /// 此為設計工具支援所需的方法 - 請勿使用程式碼編輯器修改
        /// 這個方法的內容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.Menu = new System.Windows.Forms.MenuStrip();
            this.File = new System.Windows.Forms.ToolStripMenuItem();
            this.Open = new System.Windows.Forms.ToolStripMenuItem();
            this.openFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.SaveAs = new System.Windows.Forms.ToolStripMenuItem();
            this.TextSize = new System.Windows.Forms.ToolStripMenuItem();
            this.設定字型ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.About = new System.Windows.Forms.ToolStripMenuItem();
            this.Info = new System.Windows.Forms.ToolStripMenuItem();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.翻譯此題ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.Description = new System.Windows.Forms.TextBox();
            this.ButtonA = new System.Windows.Forms.Button();
            this.ButtonB = new System.Windows.Forms.Button();
            this.ButtonD = new System.Windows.Forms.Button();
            this.ButtonC = new System.Windows.Forms.Button();
            this.Redo = new System.Windows.Forms.Button();
            this.Next = new System.Windows.Forms.Button();
            this.Previous = new System.Windows.Forms.Button();
            this.ChapterName = new System.Windows.Forms.Label();
            this.ChangeLO = new System.Windows.Forms.Button();
            this.SkipYesNo = new System.Windows.Forms.CheckBox();
            this.SkipRandom = new System.Windows.Forms.CheckBox();
            this.Progress = new System.Windows.Forms.Label();
            this.CorrectWrong = new System.Windows.Forms.Label();
            this.Show__Previous = new System.Windows.Forms.Button();
            this.translate = new System.Windows.Forms.Button();
            this.Menu.SuspendLayout();
            this.contextMenuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // Menu
            // 
            this.Menu.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.Menu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.File,
            this.TextSize,
            this.About});
            this.Menu.Location = new System.Drawing.Point(0, 0);
            this.Menu.Name = "Menu";
            this.Menu.Padding = new System.Windows.Forms.Padding(8, 2, 0, 2);
            this.Menu.Size = new System.Drawing.Size(1045, 27);
            this.Menu.TabIndex = 0;
            this.Menu.Text = "menuStrip1";
            // 
            // File
            // 
            this.File.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.Open,
            this.openFilesToolStripMenuItem,
            this.SaveAs});
            this.File.Name = "File";
            this.File.Size = new System.Drawing.Size(45, 23);
            this.File.Text = "File";
            // 
            // Open
            // 
            this.Open.Name = "Open";
            this.Open.Size = new System.Drawing.Size(216, 26);
            this.Open.Text = "Open";
            this.Open.Click += new System.EventHandler(this.Open_Click);
            // 
            // openFilesToolStripMenuItem
            // 
            this.openFilesToolStripMenuItem.Name = "openFilesToolStripMenuItem";
            this.openFilesToolStripMenuItem.Size = new System.Drawing.Size(216, 26);
            this.openFilesToolStripMenuItem.Text = "Open Files";
            this.openFilesToolStripMenuItem.Click += new System.EventHandler(this.openFilesToolStripMenuItem_Click);
            // 
            // SaveAs
            // 
            this.SaveAs.Enabled = false;
            this.SaveAs.Name = "SaveAs";
            this.SaveAs.Size = new System.Drawing.Size(216, 26);
            this.SaveAs.Text = "Save as";
            this.SaveAs.Click += new System.EventHandler(this.SaveAs_Click);
            // 
            // TextSize
            // 
            this.TextSize.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.設定字型ToolStripMenuItem});
            this.TextSize.Name = "TextSize";
            this.TextSize.Size = new System.Drawing.Size(81, 23);
            this.TextSize.Text = "Text Size";
            // 
            // 設定字型ToolStripMenuItem
            // 
            this.設定字型ToolStripMenuItem.Name = "設定字型ToolStripMenuItem";
            this.設定字型ToolStripMenuItem.Size = new System.Drawing.Size(144, 26);
            this.設定字型ToolStripMenuItem.Text = "設定字型";
            this.設定字型ToolStripMenuItem.Click += new System.EventHandler(this.設定字型ToolStripMenuItem_Click);
            // 
            // About
            // 
            this.About.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.Info});
            this.About.Name = "About";
            this.About.Size = new System.Drawing.Size(63, 23);
            this.About.Text = "About";
            // 
            // Info
            // 
            this.Info.Name = "Info";
            this.Info.Size = new System.Drawing.Size(111, 26);
            this.Info.Text = "Info";
            this.Info.Click += new System.EventHandler(this.Info_Click);
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.翻譯此題ToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(139, 28);
            // 
            // 翻譯此題ToolStripMenuItem
            // 
            this.翻譯此題ToolStripMenuItem.Name = "翻譯此題ToolStripMenuItem";
            this.翻譯此題ToolStripMenuItem.Size = new System.Drawing.Size(138, 24);
            this.翻譯此題ToolStripMenuItem.Text = "翻譯此題";
            // 
            // Description
            // 
            this.Description.Font = new System.Drawing.Font("微軟正黑體", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.Description.Location = new System.Drawing.Point(20, 78);
            this.Description.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Description.Multiline = true;
            this.Description.Name = "Description";
            this.Description.ReadOnly = true;
            this.Description.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.Description.Size = new System.Drawing.Size(1008, 364);
            this.Description.TabIndex = 2;
            // 
            // ButtonA
            // 
            this.ButtonA.AutoSize = true;
            this.ButtonA.BackColor = System.Drawing.Color.LightGray;
            this.ButtonA.Enabled = false;
            this.ButtonA.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.ButtonA.Location = new System.Drawing.Point(20, 450);
            this.ButtonA.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ButtonA.Name = "ButtonA";
            this.ButtonA.Size = new System.Drawing.Size(493, 50);
            this.ButtonA.TabIndex = 3;
            this.ButtonA.Text = "A";
            this.ButtonA.UseVisualStyleBackColor = false;
            this.ButtonA.Click += new System.EventHandler(this.ButtonA_Click);
            // 
            // ButtonB
            // 
            this.ButtonB.AutoSize = true;
            this.ButtonB.BackColor = System.Drawing.Color.LightGray;
            this.ButtonB.Enabled = false;
            this.ButtonB.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.ButtonB.Location = new System.Drawing.Point(536, 450);
            this.ButtonB.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ButtonB.Name = "ButtonB";
            this.ButtonB.Size = new System.Drawing.Size(493, 50);
            this.ButtonB.TabIndex = 4;
            this.ButtonB.Text = "B";
            this.ButtonB.UseVisualStyleBackColor = false;
            this.ButtonB.Click += new System.EventHandler(this.ButtonB_Click);
            // 
            // ButtonD
            // 
            this.ButtonD.AutoSize = true;
            this.ButtonD.BackColor = System.Drawing.Color.LightGray;
            this.ButtonD.Enabled = false;
            this.ButtonD.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.ButtonD.Location = new System.Drawing.Point(536, 512);
            this.ButtonD.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ButtonD.Name = "ButtonD";
            this.ButtonD.Size = new System.Drawing.Size(493, 50);
            this.ButtonD.TabIndex = 6;
            this.ButtonD.Text = "D";
            this.ButtonD.UseVisualStyleBackColor = false;
            this.ButtonD.Click += new System.EventHandler(this.ButtonD_Click);
            // 
            // ButtonC
            // 
            this.ButtonC.AutoSize = true;
            this.ButtonC.BackColor = System.Drawing.Color.LightGray;
            this.ButtonC.Enabled = false;
            this.ButtonC.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.ButtonC.Location = new System.Drawing.Point(20, 512);
            this.ButtonC.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ButtonC.Name = "ButtonC";
            this.ButtonC.Size = new System.Drawing.Size(493, 50);
            this.ButtonC.TabIndex = 5;
            this.ButtonC.Text = "C";
            this.ButtonC.UseVisualStyleBackColor = false;
            this.ButtonC.Click += new System.EventHandler(this.ButtonC_Click);
            // 
            // Redo
            // 
            this.Redo.AutoSize = true;
            this.Redo.Enabled = false;
            this.Redo.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.Redo.Location = new System.Drawing.Point(20, 575);
            this.Redo.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Redo.Name = "Redo";
            this.Redo.Size = new System.Drawing.Size(119, 50);
            this.Redo.TabIndex = 7;
            this.Redo.Text = "Redo";
            this.Redo.UseVisualStyleBackColor = true;
            this.Redo.Click += new System.EventHandler(this.Redo_Click);
            // 
            // Next
            // 
            this.Next.AutoSize = true;
            this.Next.Enabled = false;
            this.Next.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.Next.Location = new System.Drawing.Point(904, 575);
            this.Next.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Next.Name = "Next";
            this.Next.Size = new System.Drawing.Size(125, 50);
            this.Next.TabIndex = 8;
            this.Next.Text = "Next";
            this.Next.UseVisualStyleBackColor = true;
            this.Next.Click += new System.EventHandler(this.Next_Click);
            // 
            // Previous
            // 
            this.Previous.AutoSize = true;
            this.Previous.Enabled = false;
            this.Previous.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.Previous.Location = new System.Drawing.Point(745, 575);
            this.Previous.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Previous.Name = "Previous";
            this.Previous.Size = new System.Drawing.Size(151, 50);
            this.Previous.TabIndex = 9;
            this.Previous.Text = "Previous";
            this.Previous.UseVisualStyleBackColor = true;
            this.Previous.Click += new System.EventHandler(this.Previous_Click);
            // 
            // ChapterName
            // 
            this.ChapterName.AutoSize = true;
            this.ChapterName.Font = new System.Drawing.Font("微軟正黑體", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.ChapterName.Location = new System.Drawing.Point(16, 41);
            this.ChapterName.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.ChapterName.Name = "ChapterName";
            this.ChapterName.Size = new System.Drawing.Size(95, 22);
            this.ChapterName.TabIndex = 10;
            this.ChapterName.Text = "請選擇檔案";
            // 
            // ChangeLO
            // 
            this.ChangeLO.AutoSize = true;
            this.ChangeLO.Enabled = false;
            this.ChangeLO.Font = new System.Drawing.Font("微軟正黑體", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.ChangeLO.Location = new System.Drawing.Point(424, 36);
            this.ChangeLO.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.ChangeLO.Name = "ChangeLO";
            this.ChangeLO.Size = new System.Drawing.Size(145, 34);
            this.ChangeLO.TabIndex = 12;
            this.ChangeLO.Text = "讀入／重讀題目";
            this.ChangeLO.UseVisualStyleBackColor = true;
            this.ChangeLO.Click += new System.EventHandler(this.ChangeLO_Click);
            // 
            // SkipYesNo
            // 
            this.SkipYesNo.AutoSize = true;
            this.SkipYesNo.Location = new System.Drawing.Point(177, 44);
            this.SkipYesNo.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.SkipYesNo.Name = "SkipYesNo";
            this.SkipYesNo.Size = new System.Drawing.Size(89, 19);
            this.SkipYesNo.TabIndex = 13;
            this.SkipYesNo.Text = "跳過是非";
            this.SkipYesNo.UseVisualStyleBackColor = true;
            this.SkipYesNo.CheckedChanged += new System.EventHandler(this.SkipYesNo_CheckedChanged);
            // 
            // SkipRandom
            // 
            this.SkipRandom.AutoSize = true;
            this.SkipRandom.Location = new System.Drawing.Point(280, 44);
            this.SkipRandom.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.SkipRandom.Name = "SkipRandom";
            this.SkipRandom.Size = new System.Drawing.Size(89, 19);
            this.SkipRandom.TabIndex = 14;
            this.SkipRandom.Text = "跳過隨機";
            this.SkipRandom.UseVisualStyleBackColor = true;
            this.SkipRandom.CheckedChanged += new System.EventHandler(this.SkipRandom_CheckedChanged);
            // 
            // Progress
            // 
            this.Progress.AutoSize = true;
            this.Progress.Location = new System.Drawing.Point(809, 45);
            this.Progress.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.Progress.Name = "Progress";
            this.Progress.Size = new System.Drawing.Size(55, 15);
            this.Progress.TabIndex = 15;
            this.Progress.Text = "進度:-/-";
            // 
            // CorrectWrong
            // 
            this.CorrectWrong.AutoSize = true;
            this.CorrectWrong.Location = new System.Drawing.Point(896, 45);
            this.CorrectWrong.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.CorrectWrong.Name = "CorrectWrong";
            this.CorrectWrong.Size = new System.Drawing.Size(124, 15);
            this.CorrectWrong.TabIndex = 16;
            this.CorrectWrong.Text = "correct: 0 / wrong: 0";
            // 
            // Show__Previous
            // 
            this.Show__Previous.AutoSize = true;
            this.Show__Previous.Enabled = false;
            this.Show__Previous.Font = new System.Drawing.Font("微軟正黑體", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.Show__Previous.Location = new System.Drawing.Point(609, 36);
            this.Show__Previous.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Show__Previous.Name = "Show__Previous";
            this.Show__Previous.Size = new System.Drawing.Size(133, 34);
            this.Show__Previous.TabIndex = 17;
            this.Show__Previous.Text = "顯示上次答案";
            this.Show__Previous.UseVisualStyleBackColor = true;
            this.Show__Previous.Click += new System.EventHandler(this.Show__Previous_Click);
            // 
            // translate
            // 
            this.translate.AutoSize = true;
            this.translate.Font = new System.Drawing.Font("微軟正黑體", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.translate.Location = new System.Drawing.Point(147, 575);
            this.translate.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.translate.Name = "translate";
            this.translate.Size = new System.Drawing.Size(119, 50);
            this.translate.TabIndex = 7;
            this.translate.Text = "翻譯";
            this.translate.UseVisualStyleBackColor = true;
            this.translate.Click += new System.EventHandler(this.Translate_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1045, 639);
            this.Controls.Add(this.Show__Previous);
            this.Controls.Add(this.CorrectWrong);
            this.Controls.Add(this.Progress);
            this.Controls.Add(this.SkipRandom);
            this.Controls.Add(this.SkipYesNo);
            this.Controls.Add(this.ChangeLO);
            this.Controls.Add(this.ChapterName);
            this.Controls.Add(this.Previous);
            this.Controls.Add(this.Next);
            this.Controls.Add(this.translate);
            this.Controls.Add(this.Redo);
            this.Controls.Add(this.ButtonD);
            this.Controls.Add(this.ButtonC);
            this.Controls.Add(this.ButtonB);
            this.Controls.Add(this.ButtonA);
            this.Controls.Add(this.Description);
            this.Controls.Add(this.Menu);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MainMenuStrip = this.Menu;
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form1";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Form1_FormClosed);
            this.Menu.ResumeLayout(false);
            this.Menu.PerformLayout();
            this.contextMenuStrip1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip Menu;
        private System.Windows.Forms.ToolStripMenuItem File;
        private System.Windows.Forms.ToolStripMenuItem Open;
        private System.Windows.Forms.ToolStripMenuItem SaveAs;
        private System.Windows.Forms.ToolStripMenuItem TextSize;
        private System.Windows.Forms.ToolStripMenuItem About;
        private System.Windows.Forms.ToolStripMenuItem Info;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.TextBox Description;
        private System.Windows.Forms.Button ButtonA;
        private System.Windows.Forms.Button ButtonB;
        private System.Windows.Forms.Button ButtonD;
        private System.Windows.Forms.Button ButtonC;
        private System.Windows.Forms.Button Redo;
        private System.Windows.Forms.Button Next;
        private System.Windows.Forms.Button Previous;
        private System.Windows.Forms.Label ChapterName;
        private System.Windows.Forms.Button ChangeLO;
        private System.Windows.Forms.CheckBox SkipYesNo;
        private System.Windows.Forms.CheckBox SkipRandom;
        private System.Windows.Forms.Label Progress;
        private System.Windows.Forms.Label CorrectWrong;
        private System.Windows.Forms.ToolStripMenuItem 設定字型ToolStripMenuItem;
        private System.Windows.Forms.Button Show__Previous;
        private System.Windows.Forms.ToolStripMenuItem 翻譯此題ToolStripMenuItem;
        private System.Windows.Forms.Button translate;
        private System.Windows.Forms.ToolStripMenuItem openFilesToolStripMenuItem;
    }
}

