-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-06-16 08:19:55
-- 伺服器版本： 10.4.28-MariaDB
-- PHP 版本： 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `audit-multiple-choice`
--

-- --------------------------------------------------------

--
-- 資料表結構 `announcement`
--

CREATE TABLE `announcement` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `announcement`
--

INSERT INTO `announcement` (`id`, `title`, `content`) VALUES
(1, '公告測試', '新增公告功能，麻煩各位同學於週三晚上問卷上線後撥空填寫，非常感謝！<BR>祝期末歐趴'),
(2, '回饋表單 <span class=\"badge badge-danger\">重要</span>', '麻煩各位同學撥空填寫問卷，非常感謝！<a href=\"https://forms.gle/L7gQtZzYr9N1jQAe8\" target=\"_blank\">https://forms.gle/L7gQtZzYr9N1jQAe8</a><BR>因6/15下午要報告希望在中午前填寫完畢，祝各位期末順利<BR>\r\n如果有遇到<ul>\r\n<li>題目跑不出來</li>\r\n<li>首頁未顯示學號</li>\r\n</ul>請使用新分頁重新登入<BR>\r\n歡迎多利用「聯絡我們」回報問題，將盡快處理。');

-- --------------------------------------------------------

--
-- 資料表結構 `contact_us`
--

CREATE TABLE `contact_us` (
  `ID` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `subject` text NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `h14086030_log_table`
--

CREATE TABLE `h14086030_log_table` (
  `log_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `time` datetime NOT NULL,
  `content` text NOT NULL,
  `total` int(11) NOT NULL,
  `correct` int(11) NOT NULL,
  `wrong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `h14086030_log_table`
--

INSERT INTO `h14086030_log_table` (`log_id`, `name`, `time`, `content`, `total`, `correct`, `wrong`) VALUES
(1, '123', '2023-06-10 20:28:42', '[{\"chapter\":\"7\",\"lo\":\"LO6\"}]', 24, 6, 7),
(3, '合併記錄檔', '2023-06-10 20:29:34', '1:錯誤/', 7, 0, 0),
(4, '合併記錄檔', '2023-06-10 21:19:44', '1:正確/', 6, 1, 4),
(5, '合併記錄檔', '2023-06-10 21:28:03', '3:未作答/', 7, 0, 0),
(8, '合併記錄檔', '2023-06-10 21:42:29', '3:未作答/4:錯誤未作答/5:未作答/', 12, 0, 0),
(9, '2023-06-15 01:59:00', '2023-06-15 01:59:00', '[{\"chapter\":\"7\",\"lo\":\"LO2\"},{\"chapter\":\"7\",\"lo\":\"LO5\"},{\"chapter\":\"9\",\"lo\":\"LO6\"},{\"chapter\":\"9\",\"lo\":\"LO5\"}]', 44, 10, 16),
(10, '2023-06-15 02:10:00', '2023-06-15 02:10:00', '[{\"chapter\":\"7\",\"lo\":\"LO4\"}]', 8, 0, 0),
(11, '345', '2023-06-15 15:11:21', '3:未作答/4:錯誤未作答/', 12, 1, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `h14086030_question_table`
--

CREATE TABLE `h14086030_question_table` (
  `ID` int(11) NOT NULL,
  `QID` int(11) NOT NULL,
  `sequence` varchar(10) DEFAULT NULL,
  `ans` text NOT NULL,
  `user_ans` text DEFAULT NULL,
  `chapter` text DEFAULT NULL,
  `LO` text DEFAULT NULL,
  `log_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `h14086030_question_table`
--

INSERT INTO `h14086030_question_table` (`ID`, `QID`, `sequence`, `ans`, `user_ans`, `chapter`, `LO`, `log_ID`) VALUES
(1, 85, '0123', '2', '1', '7', 'LO6', 1),
(2, 86, '3201', '1', '3', '7', 'LO6', 1),
(3, 87, '1203', '0', '1', '7', 'LO6', 1),
(4, 88, '0123', '3', '3', '7', 'LO6', 1),
(5, 89, '1203', '1', '1', '7', 'LO6', 1),
(6, 90, '1032', '3', '3', '7', 'LO6', 1),
(7, 91, '2310', '1', '1', '7', 'LO6', 1),
(8, 92, '3120', '2', '3', '7', 'LO6', 1),
(9, 93, '0321', '3', '1', '7', 'LO6', 1),
(10, 94, '0321', '3', '3', '7', 'LO6', 1),
(11, 95, '2031', '1', '3', '7', 'LO6', 1),
(12, 96, '2013', '1', '1', '7', 'LO6', 1),
(13, 97, '1302', '2', '3', '7', 'LO6', 1),
(14, 98, '2301', '1', NULL, '7', 'LO6', 1),
(15, 99, NULL, 'T', NULL, '7', 'LO6', 1),
(16, 100, NULL, 'T', NULL, '7', 'LO6', 1),
(17, 101, NULL, 'T', NULL, '7', 'LO6', 1),
(18, 102, NULL, 'F', NULL, '7', 'LO6', 1),
(19, 103, NULL, 'T', NULL, '7', 'LO6', 1),
(20, 104, NULL, 'F', NULL, '7', 'LO6', 1),
(21, 105, NULL, 'T', NULL, '7', 'LO6', 1),
(22, 106, NULL, 'F', NULL, '7', 'LO6', 1),
(23, 107, NULL, 'T', NULL, '7', 'LO6', 1),
(24, 108, NULL, 'F', NULL, '7', 'LO6', 1),
(25, 87, '1023', '0', NULL, '7', 'LO6', 3),
(26, 86, '0132', '3', NULL, '7', 'LO6', 3),
(27, 85, '2310', '0', NULL, '7', 'LO6', 3),
(28, 92, '2130', '0', NULL, '7', 'LO6', 3),
(29, 93, '2103', '1', NULL, '7', 'LO6', 3),
(30, 97, '2301', '2', NULL, '7', 'LO6', 3),
(31, 95, '1032', '1', NULL, '7', 'LO6', 3),
(32, 94, '3120', '1', '1', '7', 'LO6', 4),
(33, 91, '0132', '2', '3', '7', 'LO6', 4),
(34, 88, '0213', '3', '1', '7', 'LO6', 4),
(35, 90, '3210', '1', '3', '7', 'LO6', 4),
(36, 89, '2310', '0', '1', '7', 'LO6', 4),
(37, 96, '3120', '3', NULL, '7', 'LO6', 4),
(38, 95, '2103', '2', NULL, '7', 'LO6', 5),
(39, 93, '2013', '2', NULL, '7', 'LO6', 5),
(40, 85, '3102', '3', NULL, '7', 'LO6', 5),
(41, 92, '1320', '2', NULL, '7', 'LO6', 5),
(42, 86, '2013', '0', NULL, '7', 'LO6', 5),
(43, 87, '0123', '1', NULL, '7', 'LO6', 5),
(44, 97, '1320', '3', NULL, '7', 'LO6', 5),
(45, 97, '2031', '1', NULL, '7', 'LO6', 8),
(46, 89, '1230', '1', NULL, '7', 'LO6', 8),
(47, 95, '3012', '1', NULL, '7', 'LO6', 8),
(48, 96, '0321', '0', NULL, '7', 'LO6', 8),
(49, 93, '0321', '3', NULL, '7', 'LO6', 8),
(50, 92, '3102', '3', NULL, '7', 'LO6', 8),
(51, 87, '1230', '0', NULL, '7', 'LO6', 8),
(52, 90, '2130', '0', NULL, '7', 'LO6', 8),
(53, 85, '1032', '3', NULL, '7', 'LO6', 8),
(54, 88, '1302', '1', NULL, '7', 'LO6', 8),
(55, 91, '0312', '1', NULL, '7', 'LO6', 8),
(56, 86, '2301', '0', NULL, '7', 'LO6', 8),
(57, 35, '2130', '1', '1', '7', 'LO2', 9),
(58, 32, '2130', '0', '3', '7', 'LO2', 9),
(59, 31, '2301', '2', '1', '7', 'LO2', 9),
(60, 280, '2310', '3', '3', '9', 'LO6', 9),
(61, 81, '2310', '1', '3', '7', 'LO5', 9),
(62, 283, '0132', '3', '3', '9', 'LO6', 9),
(63, 34, '0321', '3', '3', '7', 'LO2', 9),
(64, 15, '2013', '3', '3', '7', 'LO2', 9),
(65, 30, '3102', '0', '3', '7', 'LO2', 9),
(66, 82, '2103', '3', '1', '7', 'LO5', 9),
(67, 12, '2103', '1', '3', '7', 'LO2', 9),
(68, 282, '2130', '1', '1', '9', 'LO6', 9),
(69, 24, '0231', '3', '3', '7', 'LO2', 9),
(70, 23, '2301', '0', '3', '7', 'LO2', 9),
(71, 26, '3210', '1', '3', '7', 'LO2', 9),
(72, 29, '2130', '1', '3', '7', 'LO2', 9),
(73, 285, '1320', '3', '3', '9', 'LO6', 9),
(74, 22, '2103', '0', '3', '7', 'LO2', 9),
(75, 25, '0123', '1', '3', '7', 'LO2', 9),
(76, 33, '3021', '2', '3', '7', 'LO2', 9),
(77, 10, '2031', '1', '3', '7', 'LO2', 9),
(78, 277, '0132', '3', '3', '9', 'LO6', 9),
(79, 17, '2031', '2', '3', '7', 'LO2', 9),
(80, 275, '1203', '1', '3', '9', 'LO6', 9),
(81, 279, '0123', '3', '3', '9', 'LO6', 9),
(82, 281, '2310', '0', '2', '9', 'LO6', 9),
(83, 271, '2031', '1', NULL, '9', 'LO5', 9),
(84, 276, '2031', '0', NULL, '9', 'LO6', 9),
(85, 16, '2103', '1', NULL, '7', 'LO2', 9),
(86, 20, '3210', '3', NULL, '7', 'LO2', 9),
(87, 11, '0132', '0', NULL, '7', 'LO2', 9),
(88, 284, '1230', '1', NULL, '9', 'LO6', 9),
(89, 79, '3120', '2', NULL, '7', 'LO5', 9),
(90, 21, '0213', '0', NULL, '7', 'LO2', 9),
(91, 272, '3120', '3', NULL, '9', 'LO5', 9),
(92, 13, '1320', '2', NULL, '7', 'LO2', 9),
(93, 14, '1203', '2', NULL, '7', 'LO2', 9),
(94, 80, '3201', '2', NULL, '7', 'LO5', 9),
(95, 270, '2130', '3', NULL, '9', 'LO5', 9),
(96, 19, '3120', '1', NULL, '7', 'LO2', 9),
(97, 27, '3120', '2', NULL, '7', 'LO2', 9),
(98, 18, '2013', '2', NULL, '7', 'LO2', 9),
(99, 278, '1230', '2', NULL, '9', 'LO6', 9),
(100, 28, '3201', '0', NULL, '7', 'LO2', 9),
(101, 75, NULL, 'T', NULL, '7', 'LO4', 10),
(102, 76, NULL, 'T', NULL, '7', 'LO4', 10),
(103, 77, NULL, 'F', NULL, '7', 'LO4', 10),
(104, 71, '0123', '2', NULL, '7', 'LO4', 10),
(105, 78, NULL, 'T', NULL, '7', 'LO4', 10),
(106, 72, '2310', '1', NULL, '7', 'LO4', 10),
(107, 74, '3012', '2', NULL, '7', 'LO4', 10),
(108, 73, '3201', '2', NULL, '7', 'LO4', 10),
(109, 91, '0312', '1', '1', '7', 'LO6', 11),
(110, 95, '0321', '0', NULL, '7', 'LO6', 11),
(111, 97, '3210', '3', NULL, '7', 'LO6', 11),
(112, 89, '1023', '2', NULL, '7', 'LO6', 11),
(113, 90, '2013', '0', NULL, '7', 'LO6', 11),
(114, 88, '2103', '3', NULL, '7', 'LO6', 11),
(115, 93, '1023', '0', NULL, '7', 'LO6', 11),
(116, 92, '2013', '0', NULL, '7', 'LO6', 11),
(117, 96, '1320', '3', NULL, '7', 'LO6', 11),
(118, 87, '0231', '3', NULL, '7', 'LO6', 11),
(119, 86, '1203', '1', NULL, '7', 'LO6', 11),
(120, 85, '0132', '3', NULL, '7', 'LO6', 11);

-- --------------------------------------------------------

--
-- 資料表結構 `question_table`
--

CREATE TABLE `question_table` (
  `id` int(11) NOT NULL,
  `question` text DEFAULT NULL,
  `option_a` text DEFAULT NULL,
  `option_b` text DEFAULT NULL,
  `option_c` text DEFAULT NULL,
  `option_d` text DEFAULT NULL,
  `answer` varchar(10) DEFAULT NULL,
  `chapter` varchar(10) NOT NULL,
  `LO` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `question_table`
--

INSERT INTO `question_table` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `answer`, `chapter`, `LO`) VALUES
(1, 'A measure of how willing the auditor is to accept that the financial statements may be materially misstated after the audit is completed and an unqualified opinion has been issued is the\n', 'inherent risk.\n', 'acceptable audit risk.\n', 'statistical risk.\n', 'financial risk.\n', '1', '7', 'LO1'),
(2, 'The first phase in planning an audit and designing an audit approach is to\n', 'accept the client and perform initial audit planning.\n', 'set the preliminary judgment of materiality.\n', 'understand the client\'s business and industry.\n', 'perform preliminary audit procedures.\n', '0', '7', 'LO1'),
(3, '_______ is the risk that the financial statements contain a material misstatement due to fraud or error prior to the audit.\n', 'Inherent risk\n', 'Client business risk\n', 'Acceptable audit risk\n', 'Risk of material misstatement\n', '3', '7', 'LO1'),
(4, 'In what order should the following steps occur?\nA.	Set preliminary judgment of materiality and performance materiality.\nB.	Understand the clients business and industry.\nC.	Perform preliminary analytical procedures.\nD.	Accept the client and perform initial audit planning.\n', 'D, B, C, A\n', 'B, A, C, D\n', 'B, D, A, C\n', 'D, C, B, A\n', '0', '7', 'LO1'),
(5, 'The auditor uses knowledge gained from the understanding of the client\'s business and industry to assess\n', 'client business risk.\n', 'control risk.\n', 'inherent risk.\n', 'audit risk.\n', '0', '7', 'LO1'),
(6, 'When an auditor sets a low acceptable audit risk, it means that he wants to be more certain that the financial statements are not materially misstated.\n', '', '', '', '', 'T', '7', 'LO1'),
(7, 'As acceptable audit risk is decreased, the likely cost of conducting an audit increases.\n', '', '', '', '', 'T', '7', 'LO1'),
(8, 'Assessing acceptable audit risk, client business risk, and risk of material misstatement helps determine the audit procedures that will be needed.\n', '', '', '', '', 'T', '7', 'LO1'),
(9, 'A 100 % audit risk is complete certainty.\n', '', '', '', '', 'F', '7', 'LO1'),
(10, 'One of the purposes of an engagement letter is to avoid misunderstandings with the client. This is important for\n', '\nEngagement objectives	Engagement limitations\nYes	Yes\n\n', '\nEngagement objectives 	Engagement limitations\nNo	No\n\n', '\nEngagement objectives	Engagement limitations\nYes	No\n\n', '\nEngagement objectives	Engagement limitations\nNo	Yes\n\n', '0', '7', 'LO2'),
(11, 'The auditor is likely to accumulate more evidence when the audit is for a company\n', '\nWhich has large amounts of debt	Which is to be sold in the near future\nYes	Yes\n\n', '\nWhich has large amounts of debt	Which is to be sold in the near future\nNo	No\n\n', '\nWhich has large amounts of debt	Which is to be sold in the near future\nYes	No\n\n', '\nWhich has large amounts of debt	Which is to be sold in the near future\nNo	Yes\n\n', '0', '7', 'LO2'),
(12, 'Initial audit planning involves four matters. Which of the following is not one of these?\n', 'Develop an overall audit strategy.\n', 'Request that bank balances be confirmed.\n', 'Schedule engagement staff and audit specialists.\n', 'Identify the client\'s reason for the audit.\n', '1', '7', 'LO2'),
(13, 'Smith, CPA, has requested permission to communicate with the predecessor auditor in order to review certain workpapers for high risk accounts for a new audit client. The new audit client\'s refusal to allow this communication to occur would impact Smith\'s decision concerning\n', 'the auditor\'s ability to design audit tests.\n', 'possible scope exception due to lack of access.\n', 'the desirability of accepting the prospective engagement.\n', 'violation of the GAAP rules concerning consistency and comparability of financial information.\n', '2', '7', 'LO2'),
(14, 'A successor auditor may perform which of the following for a new audit client?\n', '\nSpeak to local attorneys, banks and other businesses regarding the company\'s reputation 	Speak to the predecessor auditors about disagreements they had with management\nYes	Yes\n\n', '\nSpeak to local attorneys, banks and other businesses regarding the company\'s reputation 	Speak to the predecessor auditors about disagreements they had with management\nNo	No\n\n', '\nSpeak to local attorneys, banks and other businesses regarding the company\'s reputation 	Speak to the predecessor auditors about disagreements they had with management\nYes	No\n\n', '\nSpeak to local attorneys, banks and other businesses regarding the company\'s reputation 	Speak to the predecessor auditors about disagreements they had with management\nNo	Yes\n\n', '0', '7', 'LO2'),
(15, 'When dealing with audit risk,\n', 'audit risk should not be a factor when determining if a new client should be accepted.\n', 'audits with a low acceptable audit risk generally result in lower audit fees.\n', 'if management of a company has a reputation of integrity, but is also known to take aggressive financial risks, the auditor should not accept the company as a new client.\n', 'if the auditor concludes that acceptable audit risk is low, but the client is still acceptable, the auditor may still accept the engagement but increase the fee proposed to the client.\n', '3', '7', 'LO2'),
(16, 'A written understanding detailing what the auditor expects from the client in performing an audit will normally be expressed in the\n', 'management letter requested by the auditor.\n', 'engagement letter.\n', 'audit Plan.\n', 'audit Strategy for the client.\n', '1', '7', 'LO2'),
(17, 'For public companies, the ________ is responsible for hiring the auditor as required by the Sarbanes-Oxley Act.\n', 'client\'s management\n', 'client\'s chief executive officer\n', 'client\'s chief financial officer\n', 'client\'s audit committee\n', '3', '7', 'LO2'),
(18, 'Which of the following statements is true regarding communications between predecessor and successor auditors? \n', 'The burden of initiating the communication rests with the predecessor.\n', 'The predecessor\'s response can be limited to stating that no information will be provided.\n', 'The predecessor should communicate with the successor only if the client is public.\n', 'The predecessor auditor of a public company does not need permission from the client before communicating with the successor auditor.\n', '1', '7', 'LO2'),
(19, 'The purpose of an engagement letter is to\n', 'document the CPA firm\'s responsibility to external users of the audited financial statements.\n', 'document the terms of the engagement.\n', 'notify the audit staff of an upcoming engagement so that personnel scheduling can be facilitated.\n', 'emphasize management\'s responsibility for approving the audit program.\n', '1', '7', 'LO2'),
(20, 'The written communication stating the auditor cannot guarantee that all acts of fraud will be discovered is found in the\n', 'engagement letter.\n', 'representation letter.\n', 'responsibility letter.\n', 'client letter.\n', '0', '7', 'LO2'),
(21, 'Which of the following normally signs the engagement letter for an audit of a private company?\n', 'management\n', 'board of directors representative\n', 'audit committee representative\n', 'corporate treasurer\n', '0', '7', 'LO2'),
(22, 'The two major factors affecting acceptable audit risk are\n', 'inherent risk and the intended uses of the financial statements.\n', 'control risk and the intended uses of the financial statements.\n', 'the likely statement users and their intended uses of the statements.\n', 'the audit firm and the intended uses of the statements\n', '2', '7', 'LO2'),
(23, 'An engagement letter sent to a publicly held audit client usually would not include a(n)\n', 'reference to the auditor\'s responsibility for the detection of errors or irregularities.\n', 'estimation of the time to be spent on the audit work by audit staff and management.\n', 'statement that management advisory services would be made available upon request.\n', 'reference to management\'s responsibility for the financial statements.\n', '2', '7', 'LO2'),
(24, 'The preliminary audit strategy\n', 'is set before the auditor understands the client\'s reasons for the audit.\n', 'guides the development of the audit plan.\n', 'is determined after the engagement staffing is set.\n', 'is the detailed steps to be followed for the substantive audit tests.\n', '1', '7', 'LO2'),
(25, 'The purpose of the requirement in having communication between the predecessor and successor auditors is to\n', 'allow the predecessor to disclose information which would otherwise be confidential.\n', 'help the successor auditor to evaluate whether to accept the engagement.\n', 'help the client by facilitating the change of auditors.\n', 'ensure the predecessor collects all unpaid fees prior to a change in auditor.\n', '1', '7', 'LO2'),
(26, 'The predecessor auditor is required to respond to the request of the successor auditor for information, but the response can be limited to stating that no information will be provided when\n', 'the predecessor auditor has poor relations with the successor auditor.\n', 'the client is dissatisfied with the predecessor\'s work.\n', 'there are actual or potential legal problems between the client and the predecessor.\n', 'the predecessor believes that the client lacks integrity.\n', '2', '7', 'LO2'),
(27, 'Which of the following best expresses the understanding of the terms of the engagement that exist between the client and the CPA firm?\n', 'Management asserts there are no errors, material or immaterial, in the general ledger.\n', 'Auditors assert that the primary audit goal is audit efficiency.\n', 'Auditors assert that their primary responsibility is to plan and perform the audit in order to provide reasonable assurance as to the detection of material misstatement due to error or fraud.\n', 'Management asserts that they will provide the auditor with a risk assessment as to material misstatements due to errors or fraud in the company\'s financial statements.\n', '2', '7', 'LO2'),
(28, 'When selecting staff for the audit engagement\n', 'only staff members who are CPAs should be assigned to the audit.\n', 'only managers and above need to have appropriate competence and capabilities to perform the audit.\n', 'continuity of staff members from year to year should not be a factor.\n', 'staff assigned to the audit must be knowledgeable about the client\'s industry.\n', '3', '7', 'LO2'),
(29, 'When developing the overall strategy for the audit, the auditor will\n', 'decide whether to accept a new client.\n', 'determine if any audit specialists will be required.\n', 'identify why the auditor needs an audit.\n', 'obtain an engagement letter.\n', '1', '7', 'LO2'),
(30, 'Which is usually included in an engagement letter?\n', '\nEstimate of hours required to \ncomplete audit	Dollar estimate of fees to be billed to the client\nYes	Yes\n\n', '\nEstimate of hours required to \ncomplete audit	Dollar estimate of fees to be billed to the client\nNo	No\n\n', '\nEstimate of hours required to \ncomplete audit	Dollar estimate of fees to be billed to the client\nYes	No\n\n', '\nEstimate of hours required to \ncomplete audit	Dollar estimate of fees to be billed to the client\nNo	Yes\n\n', '3', '7', 'LO2'),
(31, 'Which is usually included in an engagement letter?\n', '\nThe objectives of the  engagement	Identification of the financial reporting framework used by management\nYes	Yes\n\n', '\nThe objectives of the  engagement	Identification of the financial reporting framework used by management\nNo	No\n\n', '\nThe objectives of the  engagement	Identification of the financial reporting framework used by management\nYes	No\n\n', '\nThe objectives of the  engagement	Identification of the financial reporting framework used by management\nNo	Yes\n\n', '0', '7', 'LO2'),
(32, 'Which is usually included in an engagement letter?\n', '\nThe financial statements are \nthe responsibility of the \ncompany\'s management 	Ratios to be used by the auditor in the planning phase\nYes	Yes\n\n', '\nThe financial statements are \nthe responsibility of the \ncompany\'s management 	Ratios to be used by the auditor in the planning phase\nNo	No\n\n', '\nThe financial statements are \nthe responsibility of the \ncompany\'s management 	Ratios to be used by the auditor in the planning phase\nYes	No\n\n', '\nThe financial statements are \nthe responsibility of the \ncompany\'s management 	Ratios to be used by the auditor in the planning phase\nNo	Yes\n\n', '2', '7', 'LO2'),
(33, 'When may the auditor refer to a specialist in the audit report?\n', '\nOnly if the specialist\'s report \nresults in a modification of the audit \nopinion 	Only if the specialist assisted in the audit of an account material to the financial statements\nYes	Yes\n\n', '\nOnly if the specialist\'s report \nresults in a modification of the audit \nopinion 	Only if the specialist assisted in the audit of an account material to the financial statements\nNo	No\n\n', '\nOnly if the specialist\'s report \nresults in a modification of the audit \nopinion 	Only if the specialist assisted in the audit of an account material to the financial statements\nYes	No\n\n', '\nOnly if the specialist\'s report \nresults in a modification of the audit \nopinion 	Only if the specialist assisted in the audit of an account material to the financial statements\nNo	Yes\n\n', '2', '7', 'LO2'),
(34, 'Which is usually included in the engagement letter?\n', '\nThe projected type of opinion on the financial statement to be audited 	Name(s) of the client personnel responsible for supplying the auditor with information\nYes	Yes\n\n', '\nThe projected type of opinion on the financial statement to be audited 	Name(s) of the client personnel responsible for supplying the auditor with information\nNo	No\n\n', '\nThe projected type of opinion on the financial statement to be audited 	Name(s) of the client personnel responsible for supplying the auditor with information\nYes	No\n\n', '\nThe projected type of opinion on the financial statement to be audited 	Name(s) of the client personnel responsible for supplying the auditor with information\nNo	Yes\n\n', '1', '7', 'LO2'),
(35, 'Which is usually included in the engagement letter?\n', '\nList of audit procedures to be used \nin inventory observation 	The auditors\' assessment of audit risk\nYes	Yes\n\n', '\nList of audit procedures to be used \nin inventory observation 	The auditors\' assessment of audit risk\nNo	No\n\n', '\nList of audit procedures to be used \nin inventory observation 	The auditors\' assessment of audit risk\nYes	No\n\n', '\nList of audit procedures to be used \nin inventory observation 	The auditors\' assessment of audit risk\nNo	Yes\n\n', '1', '7', 'LO2'),
(36, 'Before accepting a new client, most CPA firms investigate the company to determine its acceptability. However, AICPA confidentiality requirements prohibit CPA firms from contacting certain parties–namely the company\'s attorneys and bankers–during this investigation.\n', '', '', '', '', 'F', '7', 'LO2'),
(37, 'For prospective clients that have previously been audited by another CPA firm, the predecessor auditor must initiate the communication with the successor auditor.\n', '', '', '', '', 'F', '7', 'LO2'),
(38, 'When a successor auditor contacts a company\'s previous auditor, the predecessor auditor is required to respond fully and without limit to the request for information.\n', '', '', '', '', 'F', '7', 'LO2'),
(39, 'A predecessor auditor who has been contacted by a successor auditor for information about the client does not have to obtain permission from the former client before providing any confidential information to the successor auditor because the confidentiality requirement does not extend to former clients.\n', '', '', '', '', 'F', '7', 'LO2'),
(40, 'An auditor must evaluate a specialist\'s professional qualifications and understand the objectives of the specialist\'s work.\n', '', '', '', '', 'T', '7', 'LO2'),
(41, 'Because of audit risk, some CPA firms now refuse any new clients in certain high-risk industries.\n', '', '', '', '', 'T', '7', 'LO2'),
(42, 'An engagement letter establishes a clear understanding of the terms of the engagement between the client and the auditor.\n', '', '', '', '', 'T', '7', 'LO2'),
(43, 'Because auditors are responsible for having appropriate competence and capabilities to perform an audit, auditors are not normally permitted to consult with outside specialists during an audit engagement.\n', '', '', '', '', 'F', '7', 'LO2'),
(44, 'If a prospective client has been audited in the past, the successor auditor will typically rely solely on the representations about the client by the predecessor auditor.\n', '', '', '', '', 'F', '7', 'LO2'),
(45, 'A major consideration in audit staffing is the need for continuity from year to year.\n', '', '', '', '', 'T', '7', 'LO2'),
(46, 'When a successor auditor requests information from a company\'s previous auditor, and there are legal problems or disputes between the client and the predecessor auditor, the predecessor auditor\'s response to the new auditor may be limited to stating that no information will be provided.\n', '', '', '', '', 'T', '7', 'LO2'),
(47, 'Staff assigned to an audit engagement must be knowledgeable about the client\'s industry.\n', '', '', '', '', 'T', '7', 'LO2'),
(48, 'In order to obtain an understanding of the client\'s business, the audit firm will consider\n', 'inherent and control risk of the client.\n', 'audit risk to the CPA firm.\n', 'the client\'s business risk and the risk of material misstatements in the financial statements.\n', 'the CPA firm\'s potential ongoing revenue from the audit client.\n', '2', '7', 'LO3'),
(49, 'Most auditors assess the risk of material misstatement as high for related parties and related-party transactions because\n', 'of the unique classification of related-party transactions required on the balance sheet.\n', 'of the lack of independence between the parties.\n', 'of the unique classification of related-party transactions required on the income statement.\n', 'it is required by generally accepted accounting principles.\n', '1', '7', 'LO3'),
(50, 'A tour of the client\'s facilities provides the auditor an opportunity to \n', 'meet key personnel.\n', 'observe operations.\n', 'assess physical safeguards over assets.\n', 'all of the above\n', '3', '7', 'LO3'),
(51, 'The auditor determines that Matthews Company occupies the 3rd floor of an office tower for which it pays no rent. The most likely explanation is\n', 'they got lucky the landlord hasn\'t noticed the lack of payments.\n', 'the landlord has weak internal controls over billings.\n', 'a related party transaction in which a major shareholder owns the office tower.\n', 'Matthews Company is engaging in fraudulent activities.\n', '2', '7', 'LO3'),
(52, 'An official record of meetings of the board of directors and stockholders is included in the corporate\n', 'bylaws.\n', 'charter.\n', 'minutes.\n', 'license.\n', '2', '7', 'LO3'),
(53, 'A related party transaction may be indicated when another company\n', 'subsidizes certain operating expenses of the company.\n', 'purchases its securities at their fair value.\n', 'loans to company at market rates.\n', 'has had a distributor relationship with the company for 10 years.\n', '0', '7', 'LO3'),
(54, 'Which of the following is an accurate statement regarding a public company\'s code of ethics?\n', 'A code of ethics is required under The Foreign Corrupt Practices Act.\n', 'A code of ethics is required only for mid-level managers and below.\n', 'The SEC requires companies to disclose amendments and waivers to the code of ethics for the CEO, CFO and principal accounting officer.\n', 'The PCAOB requires companies to review their code of ethics every five years.\n', '2', '7', 'LO3'),
(55, 'An auditor should examine minutes of the board of directors\' meetings\n', 'through the date of the financial statements.\n', 'through the date of the audit report.\n', 'only at the beginning of the audit.\n', 'on a test basis.\n', '1', '7', 'LO3'),
(56, 'Which of the following would most likely not be classified as a related-party transaction?\n', 'an advance of one week\'s salary to an employee\n', 'sales of merchandise between affiliated companies\n', 'loans or credit sales to the principal owner of the client company\n', 'exchanges of equipment between two companies owned by the same person\n', '0', '7', 'LO3'),
(57, 'Which of the following best describes the corporate minutes of an entity?\n', 'official record of the meetings of the board of directors and the stockholders\n', 'unofficial record of the meeting of the board of directors\n', 'official record of management meeting with investors and creditors of the company\n', 'unofficial record of the board of directors meetings \n', '0', '7', 'LO3'),
(58, 'Related party\n', 'transactions must be disclosed in the footnotes even if the amounts are immaterial.\n', 'disclosures include the nature of the related party relationship and a description of the transaction.\n', 'transactions are considered arm\'s-length transactions.\n', 'disclosures are required only for public companies.\n', '1', '7', 'LO3'),
(59, 'Auditors should understand client objectives related to\n', 'reliability of financial reporting.\n', 'effectiveness and efficiency of operations.\n', 'compliance with laws and regulations.\n', 'all of the above.\n', '3', '7', 'LO3'),
(60, 'When analyzing a client\'s performance measurement system,\n', 'ratio analysis and benchmarking against key competitors are utilized.\n', 'only income statement numbers are used.\n', 'inherent risk of financial statement misstatements may be decreased if the performance measurement system encourages aggressive accounting.\n', 'the auditor is likely to decrease the extent of testing if the client has set unreasonable objectives.\n', '0', '7', 'LO3'),
(61, 'Auditors should obtain copies of the client\'s code of ethics and minutes of the meetings of the board of directors to aid in their understanding of the company\'s management and governance structure.\n', '', '', '', '', 'T', '7', 'LO3'),
(62, 'Many risks are common to all clients in certain industries.\n', '', '', '', '', 'T', '7', 'LO3'),
(63, 'Transactions with related parties must be disclosed in the financial statements if they are deemed to be material.\n', '', '', '', '', 'T', '7', 'LO3'),
(64, 'All known related parties must be identified and included in the auditor\'s permanent files related to the client.\n', '', '', '', '', 'T', '7', 'LO3'),
(65, 'Because of the lack of independence between related parties, the Sarbanes-Oxley Act prohibits all related party transactions.\n', '', '', '', '', 'F', '7', 'LO3'),
(66, 'Management\'s philosophy and operating style influence the risk of material misstatements in the financial statements.\n', '', '', '', '', 'T', '7', 'LO3'),
(67, 'The auditor should read the corporate minutes to obtain authorizations and other information that is relevant to performing the audit.\n', '', '', '', '', 'T', '7', 'LO3'),
(68, 'Material transactions between the client and the client\'s related parties must be disclosed in the auditor\'s report.\n', '', '', '', '', 'F', '7', 'LO3'),
(69, 'A tour of the client\'s facilities can help the auditor assess physical safeguards over assets and interpret accounting data related to assets such as factory equipment.\n', '', '', '', '', 'T', '7', 'LO3'),
(70, 'Operations are approaches followed by the entity to achieve organizational objectives.\n', '', '', '', '', 'F', '7', 'LO3'),
(71, 'Which of the following is a correct statement regarding analytical procedures?\n', 'A major strength in using industry ratios for auditing is the difference between the nature of the client\'s financial information and that of the firms making up the industry totals.\n', 'Common-size financial statements display all items as a percentage change from a base year.\n', 'In identifying areas of specific risk, the auditor is likely to focus on the liquidity activity ratios.\n', 'In order to look for a misstatement in the allowance for bad debts, the auditor should divide gross sales by sales returns and allowances.\n', '2', '7', 'LO4'),
(72, 'Which of the following would not be classified as an analytical procedure?\n', 'benchmarking the company\'s profitability ratios against others in the industry\n', 'preparing common size financial statements\n', 'calculating income statement account balances as a percent of sales when the level of sales has changed from the prior year\n', 'reconciling fixed asset dispositions with the fixed asset ledger\n', '3', '7', 'LO4'),
(73, 'When performing planning analytical procedures for a client the auditor detected that the gross profit percentage had declined by 50% from the previous year to the year currently under audit. The auditor should\n', 'investigate the possibility the client may have made an error in their cost of goods sold computation.\n', 'assist management in developing greater cost efficiencies in their product line.\n', 'prepare a going concern opinion for the client.\n', 'advise the client to have extensive disclosure to alleviate investor concerns.\n', '0', '7', 'LO4'),
(74, 'Which is a liquidity activity ratio?\n', 'profit margin\n', 'inventory turnover\n', 'return on assets\n', 'times interest earned \n', '1', '7', 'LO4'),
(75, 'When using financial ratios, the most important comparisons are to those of previous years for the company and to industry averages or similar companies for the same year.\n', '', '', '', '', 'T', '7', 'LO4'),
(76, 'Auditors perform preliminary analytical procedures to better understand the client\'s business and to assess client business risk.\n', '', '', '', '', 'T', '7', 'LO4'),
(77, 'In order to be meaningful, a company\'s ratios should be compared to their prior year\'s ratios, not industry benchmarks.\n', '', '', '', '', 'F', '7', 'LO4'),
(78, 'Preliminary analytical procedures can help the auditor assess client business risk.\n', '', '', '', '', 'T', '7', 'LO4'),
(79, 'Auditing standards define ________ as the magnitude of misstatements that individually, or when aggregated with other misstatements, could reasonably be expected to influence the economic decisions of users made on the basis of the financial statements.\n', 'fraud\n', 'inherent risk\n', 'materiality\n', 'significant\n', '2', '7', 'LO5'),
(80, 'Which of the following is part of planning?\n', 'Set materiality for the financial statements as a whole.\n', 'Estimate total misstatement in the segment.\n', 'Estimate the combined misstatement.\n', 'Compare the combined estimated with preliminary judgment.\n', '0', '7', 'LO5'),
(81, 'When dealing with materiality,\n', 'if the client refuses to correct a material misstatement, the auditor is required to adjust the financial statements.\n', 'management is responsible for determining whether financial statements are materially misstated.\n', 'materiality must be determined as as percentage of sales.\n', 'the auditor must bring any material misstatements to the client\'s attention.\n', '3', '7', 'LO5'),
(82, '________ materiality is materiality for segments of the audit.\n', 'Segment\n', 'Individual\n', 'Financial statement\n', 'Performance\n', '3', '7', 'LO5'),
(83, 'Materiality does not depend on the decisions of users who rely on the statements to make the decisions.\n', '', '', '', '', 'F', '7', 'LO5'),
(84, 'The first step in applying materiality is to determine performance materiality.\n', '', '', '', '', 'F', '7', 'LO5'),
(85, 'Audit standards require the auditor to consider materiality early in the audit. Which statement(s) regarding preliminary materiality are true?\nI.	Preliminary materiality may change during the engagement.\nII.	Preliminary materiality is the maximum amount by which the auditor believes the financials could be misstated and still not affect the decisions of reasonable users.\n', 'I only\n', 'II only\n', 'both I and II\n', 'neither I nor II\n', '2', '7', 'LO6'),
(86, 'Why do auditors establish a preliminary judgment about materiality?\n', 'to determine the appropriate level of staff to assign to the audit\n', 'so the client can know what records to make available to the auditor\n', 'to help plan the appropriate evidence to accumulate\n', 'to finalize the control risk assessment\n', '2', '7', 'LO6'),
(87, 'If an auditor establishes a relatively high level for materiality, then the auditor will\n', 'accumulate more evidence than if a lower level had been set.\n', 'accumulate less evidence than if a lower level had been set.\n', 'accumulate approximately the same evidence as would be the case were materiality lower.\n', 'accumulate an undetermined amount of evidence.\n', '1', '7', 'LO6'),
(88, 'Which of the following is a reason that the auditors may change the preliminary judgment about materiality?\n', 'The auditors decide that the preliminary judgment was too large.\n', 'The auditors decide that the preliminary judgment was too small.\n', 'Client circumstance may have changed due to qualitative events.\n', 'all of the above\n', '3', '7', 'LO6'),
(89, 'Which of the following is the primary basis used to decide materiality for a profit-oriented entity?\n', 'net sales\n', 'net assets\n', 'net income before tax\n', 'all of the above\n', '2', '7', 'LO6'),
(90, 'Auditing standards ________ that the basis used to determine the preliminary judgment about materiality be documented in the audit files.\n', 'permit\n', 'do not allow\n', 'require\n', 'strongly encourage\n', '2', '7', 'LO6'),
(91, 'Amounts involving fraud are usually considered ________ important than unintentional errors of equal dollar amounts.\n', 'less\n', 'no less\n', 'no more\n', 'more\n', '3', '7', 'LO6'),
(92, 'Qualitative factors can affect an auditor\'s assessment of materiality. Which of the following statements is true?\nI.	Misstatements that are otherwise immaterial may be material if they affect earnings trends.\nII.	Misstatements that are otherwise minor may be material if there are possible consequences arising from contractual obligations. \n', 'I only\n', 'II only\n', 'I and II\n', 'neither I nor II\n', '2', '7', 'LO6'),
(93, 'The five steps in applying materiality are listed below in random order.\n1.	Estimate the combined misstatement.\n2.	Estimate the total misstatement in the segment.\n3.	Set materiality for the financial statements as a whole.\n4.	Determine performance materiality.\n5.	Compare combined estimate with preliminary judgment about materiality.\nThe first three steps in correct sequence would be\n', '1, 2, 5 \n', '3, 4, 2 \n', '2, 1, 5 \n', '3, 2, 4\n', '1', '7', 'LO6'),
(94, 'Which of the following statements is not correct?\n', 'Materiality is a relative rather than an absolute concept.\n', 'The most important base used as the criterion for deciding materiality is total assets.\n', 'Qualitative factors as well as quantitative factors affect materiality.\n', 'Given equal dollar amounts, frauds are usually considered more important than errors.\n', '1', '7', 'LO6'),
(95, 'Certain types of misstatements are likely to be more important than other types to users, even if the dollar amounts are the same. Which of the following demonstrates this?\n', '\nAmounts involving frauds are considered more important than \nerrors of equal amount.	Misstatements that are otherwise immaterial may be material if they affect a trend in earnings.\nYes	Yes\n\n', '\nAmounts involving frauds are considered more important than \nerrors of equal amount.	Misstatements that are otherwise immaterial may be material if they affect a trend in earnings.\nNo	No\n\n', '\nAmounts involving frauds are considered more important than \nerrors of equal amount.	Misstatements that are otherwise immaterial may be material if they affect a trend in earnings.\nYes	No\n\n', '\nAmounts involving frauds are considered more important than \nerrors of equal amount.	Misstatements that are otherwise immaterial may be material if they affect a trend in earnings.\nNo	Yes\n\n', '0', '7', 'LO6'),
(96, 'When setting a preliminary judgment about materiality,\n', 'more evidence is required for a low dollar amount than for a high dollar amount.\n', 'less evidence is required for a low dollar amount than for a high dollar amount.\n', 'the same amount of evidence is required for either low or high dollar amounts.\n', 'there is no relationship between materiality and the dollar amount of evidence needed.\n', '0', '7', 'LO6'),
(97, 'Lewis Corporation has a few large accounts receivable that total one million dollars, whereas Clark Corporation has many small accounts receivable that total one million dollars. Misstatement in any one account is more significant for Lewis corporation because of the concept of\n', 'materiality.\n', 'audit risk.\n', 'reasonable assurance.\n', 'comparative analysis.\n', '0', '7', 'LO6'),
(98, 'When determining materiality,\n', 'the preliminary judgment about materiality can be increased, but not decreased during the audit.\n', 'auditing standards provide specific materiality guidelines to practitioners.\n', 'only one benchmark can be used.\n', 'the application of guidelines requires considerable professional judgment.\n', '3', '7', 'LO6'),
(99, 'Determining materiality requires professional judgment.\n', '', '', '', '', 'T', '7', 'LO6'),
(100, 'The auditor\'s preliminary judgment about materiality is the maximum amount by which the auditor believes the financial statements could be misstated and still not affect the decisions of reasonable users.\n', '', '', '', '', 'T', '7', 'LO6'),
(101, 'Preliminary judgments about materiality are often changed during the course of the engagement.\n', '', '', '', '', 'T', '7', 'LO6'),
(102, 'Net assets are the most often used base for deciding materiality.\n', '', '', '', '', 'F', '7', 'LO6'),
(103, 'The lower the dollar amount of the preliminary judgment, the more audit evidence is required.\n', '', '', '', '', 'T', '7', 'LO6'),
(104, 'Amounts involving fraud are not usually considered qualitative factors affecting the preliminary materiality judgment.\n', '', '', '', '', 'F', '7', 'LO6'),
(105, 'CPA firms can establish policy guidelines to help their auditors determine materiality.\n', '', '', '', '', 'T', '7', 'LO6'),
(106, 'Statements on Auditing Standards provide detailed, objective guidance on how auditors are to establish a preliminary materiality level, thus eliminating the need for subjective auditor judgment in this task.\n', '', '', '', '', 'F', '7', 'LO6'),
(107, 'If the preliminary judgment of materiality increases, the amount of audit evidence required will decrease.\n', '', '', '', '', 'T', '7', 'LO6'),
(108, 'Net income before taxes is the normal base used to determine materiality for a not-for-profit organization.\n', '', '', '', '', 'F', '7', 'LO6'),
(109, 'The amount(s) set by the auditor at less than the materiality for the financial statements as a whole to reduce to an appropriately low level the probability that the aggregate of uncorrected and undetected misstatements exceeds materiality for the financial statements as a whole is referred to as\n', 'the materiality range.\n', 'the error range.\n', 'tolerable materiality.\n', 'performance materiality.\n', '3', '7', 'LO7'),
(110, 'Auditors generally allocate the preliminary judgment about materiality to the:\n', 'balance sheet only.\n', 'income statement only.\n', 'income statement and balance sheet.\n', 'statement of cash flows.\n', '0', '7', 'LO7'),
(111, 'Which of the following is an incorrect statement regarding the allocation of the preliminary judgment about materiality to balance sheet accounts?\n', 'Auditors expect certain accounts to have more misstatements than others.\n', 'The allocation has virtually no effect on audit costs because the auditor must collect sufficient appropriate audit evidence.\n', 'Auditors expect to identify overstatements as well as understatements in the accounts.\n', 'Relative audit costs affect the allocation.\n', '1', '7', 'LO7'),
(112, 'Which of the following statements is true concerning the allocation of preliminary materiality?\n', 'It is necessary to allocate preliminary materiality to financial statements as a whole rather than by segments.\n', 'Preliminary materiality should be allocated to income statement accounts only.\n', 'Preliminary materiality is required by the SEC.\n', 'The PCAOB term used when preliminary materiality is allocated to segments is tolerable misstatement.\n', '3', '7', 'LO7'),
(113, 'Which of the following statements is false?\n', 'Either an overstatement of an asset account or an understatement of a liability account would have the same effect on the income statement.\n', 'A misclassification in the balance sheet will have no effect on operating income.\n', 'Either an overstatement of an asset account or an overstatement of a liability account would have the same effect on the income statement.\n', 'Either an understatement of an asset account or an overstatement of a liability account would have the same effect on the income statement.\n', '2', '7', 'LO7'),
(114, 'Which of the following are major difficulties auditors face when allocating materiality to balance sheet accounts?\n', '\nCertain accounts contain \nmore misstatements \nthan others.	Only overstatements\nneed be considered.	Audit costs can\naffect allocation.\nYes	No 	Yes\n\n', '\nCertain accounts contain \nmore misstatements \nthan others.	Only overstatements\nneed be considered.	Audit costs can\naffect allocation.\nYes	Yes	No\n\n', '\nCertain accounts contain \nmore misstatements \nthan others.	Only overstatements\nneed be considered.	Audit costs can\naffect allocation.\nYes	Yes	Yes\n\n', '\nCertain accounts contain \nmore misstatements \nthan others.	Only overstatements\nneed be considered.	Audit costs can\naffect allocation.\nNo	Yes 	No\n\n', '0', '7', 'LO7'),
(115, 'When allocating performance materiality,\n', 'it is easy to predict in advance which accounts are most likely to be misstated.\n', 'only overstatements need to be considered.\n', 'professional judgment is critical.\n', 'the sum of all the performance materiality levels cannot exceed the preliminary judgment about materiality.\n', '2', '7', 'LO7'),
(116, 'When allocating materiality, most practitioners choose to allocate to\n', 'the income statement accounts because they are more important.\n', 'the balance sheet accounts because most audits focus on the balance sheet.\n', 'both balance sheet and income statement accounts because there could be errors on either.\n', 'all of the financial statements because it is required by GAAS.\n', '1', '7', 'LO7'),
(117, 'Which of the following is a correct statement regarding performance materiality?\n', 'Determining performance materiality is necessary because auditors accumulate evidence by segments.\n', 'The level of performance materiality does not affect the amount of evidence needed.\n', 'Performance materiality cannot vary for different classes of transactions.\n', 'Performance materiality is required for public companies, but not for private companies.\n', '0', '7', 'LO7'),
(118, 'Most practitioners allocate the preliminary judgment about materiality to both the balance sheet and income statement accounts.\n', '', '', '', '', 'F', '7', 'LO7'),
(119, 'The primary purpose of allocating the preliminary judgment about materiality to financial statement accounts is to help the auditor decide the appropriate evidence to accumulate.\n', '', '', '', '', 'T', '7', 'LO7'),
(120, 'Both overstatements and understatements must be considered when allocating materiality to balance sheet accounts.\n', '', '', '', '', 'T', '7', 'LO7'),
(121, 'If an auditor assigns a tolerable misstatement of $1,000 to accounts payable, he or she would need to obtain more audit evidence for that account than if $100,000 had been assigned.\n', '', '', '', '', 'T', '7', 'LO7'),
(122, 'To maximize audit efficiency, the auditor should allocate less tolerable misstatement to accounts that can be verified by using low-cost audit procedures, such as analytical procedures, than to accounts that are more costly to audit.\n', '', '', '', '', 'T', '7', 'LO7'),
(123, 'Auditors are ________ to document the known and likely misstatements in the financial statements under audit.\n', 'permitted\n', 'required\n', 'not allowed\n', 'strongly encouraged\n', '1', '7', 'LO8'),
(124, '________ misstatements are those where the auditor can determine the amount of the misstatement in the account.\n', 'Potential\n', 'Likely\n', 'Known\n', 'Projected\n', '2', '7', 'LO8'),
(125, 'Likely misstatements can result from\n', '\nComputation of the \nsampling error for the \ncash account 	Differences between management\'s and an auditor\'s judgment about account balances 	Projections of \nmisstatements based on \nan auditor\'s tests of a\n sample from a \npopulation\nNo	Yes	Yes\n\n', '\nComputation of the \nsampling error for the \ncash account 	Differences between management\'s and an auditor\'s judgment about account balances 	Projections of \nmisstatements based on \nan auditor\'s tests of a\n sample from a \npopulation\nYes	Yes	No\n\n', '\nComputation of the \nsampling error for the \ncash account 	Differences between management\'s and an auditor\'s judgment about account balances 	Projections of \nmisstatements based on \nan auditor\'s tests of a\n sample from a \npopulation\nNo	No	Yes\n\n', '\nComputation of the \nsampling error for the \ncash account 	Differences between management\'s and an auditor\'s judgment about account balances 	Projections of \nmisstatements based on \nan auditor\'s tests of a\n sample from a \npopulation\nYes	No	No\n\n', '0', '7', 'LO8'),
(126, 'When evaluating the audit findings, the auditor should be satisfied that the\n', 'amount of known misstatement is documented in the management representation letter.\n', 'estimate of the total known and likely misstatements is less than a material amount.\n', 'estimate of the total likely misstatement includes sample error.\n', 'amount of known misstatement is acknowledged and recorded by the client.\n', '1', '7', 'LO8'),
(127, 'The preliminary judgment on materiality is compared to the total estimated misstatement amount to determine if an account balance is materially misstated.\n', '', '', '', '', 'T', '7', 'LO8'),
(128, 'Total estimated misstatements include known misstatements and projected misstatements plus a sampling error.\n', '', '', '', '', 'T', '7', 'LO8'),
(129, 'If the total misstatement of an account is known, a sampling error still needs to be determined.\n', '', '', '', '', 'F', '7', 'LO8'),
(130, 'Sampling risk results if the sample accurately represents the population.\n', '', '', '', '', 'F', '7', 'LO8'),
(131, 'If the auditor approaches the audit of the accounts in s sequential manner, the findings of the audit of accounts audited earlier can be used to revise the performance materiality established for accounts audited later.\n', '', '', '', '', 'T', '7', 'LO8'),
(132, 'Which of the following would not increase the risks of material misstatement at the overall financial statement level?\n', 'effective oversight by the board of directors\n', 'deficiencies in management\'s integrity\n', 'inadequate accounting systems\n', 'all of the above\n', '0', '8', 'LO1'),
(133, 'The auditor\'s responsibility section in an audit report states that \"…the standards require that we plan and perform the audit to obtain ________ assurance about whether the financial statements are free of material misstatement.\" What type of assurance is given?\n', 'immediate\n', 'limited\n', 'reasonable\n', 'absolute\n', '2', '8', 'LO1'),
(134, '________ risk represents the auditor\'s assessment of the susceptibility of an assertion to material misstatement, before considering the effectiveness of the client\'s internal control.\n', 'Material\n', 'Account balance\n', 'Control \n', 'Inherent\n', '3', '8', 'LO1'),
(135, 'Risk of material misstatement at the assertion level\n', 'is only relevant to account balances.\n', 'determines the nature, timing, and extent of further audit procedures.\n', 'refers to risks that are pervasive to the financial statements as a whole.\n', 'consists of business risk and inherent risk.\n', '1', '8', 'LO1'),
(136, 'The risk of material misstatement exists only at the overall financial statement level.\n', '', '', '', '', 'F', '8', 'LO1'),
(137, 'Significant changes in the industry may increase the risk of material misstatement at the assertion level.\n', '', '', '', '', 'F', '8', 'LO1'),
(138, 'Inherent risk and control risk exist independent of the audit of the financial statements.\n', '', '', '', '', 'T', '8', 'LO1'),
(139, 'Risk assessment procedures include inquiries of management and others by the auditor. As part of these procedures, the auditor should talk to\n', 'internal auditors.\n', 'board of directors.\n', 'individuals involved with regulatory compliance.\n', 'all of the above.\n', '3', '8', 'LO2'),
(140, 'Risk assessment procedures include\n', 'a required discussion among the staff members of the audit and the client regarding material misstatements in the financial statement.\n', 'determination of the type of audit opinion to issue.\n', 'observation of the entity\'s operations.\n', 'assessing acceptable audit risk.\n', '2', '8', 'LO2'),
(141, 'The performance of risk assessment procedures is designed to help the auditor obtain an understanding of the entity.\n', '', '', '', '', 'T', '8', 'LO2'),
(142, 'Auditing standards require the engagement partner to be included in discussions about the susceptibility of the client\'s financial statements to material misstatements.\n', '', '', '', '', 'T', '8', 'LO2'),
(143, 'Auditors are not allowed to make inquires of employees who are not considered management, such as marketing or sales personnel.\n', '', '', '', '', 'F', '8', 'LO2'),
(144, 'When considering the risk of misstatement due to fraud,\n', 'the risk of not detecting a material misstatement due to fraud is lower than the risk of not detecting a misstatement due to error.\n', 'the risk is only made at the financial statement level.\n', 'auditing standards require the auditor to presume that risk of fraud exist in expense transactions.\n', 'auditing standards outline procedures the auditor should perform to obtain information from management about their consideration of fraud.\n', '3', '8', 'LO3'),
(145, 'Individuals engaged in conducting a fraud will generally not misrepresent information to the auditor.\n', '', '', '', '', 'F', '8', 'LO3'),
(146, 'The auditor\'s risk assessment for fraud should be ongoing throughout the audit.\n', '', '', '', '', 'T', '8', 'LO3'),
(147, 'A ________ risk represents an identified and assessed risk of material misstatement that, in the auditor\'s professional judgment, requires special audit consideration.\n', 'material\n', 'substantial\n', 'financial statement\n', 'significant\n', '3', '8', 'LO4'),
(148, 'Which of the following will generally be considered a significant risk?\n', 'a sale to a customer\n', 'the determination of the amount of bad debt expense\n', 'the purchase of inventory\n', 'obtaining a loan from the bank\n', '1', '8', 'LO4'),
(149, 'Significant risks often relate to routine transactions.\n', '', '', '', '', 'F', '8', 'LO4'),
(150, 'The auditor must perform substantive tests related to assertions deemed to have significant risks.\n', '', '', '', '', 'T', '8', 'LO4'),
(151, 'Which of the following risks are used in the audit risk model?\n', '\nControl Risk	Inherent Risk	Planned Detection Risk\nYes	Yes	Yes\n\n', '\nControl Risk	Inherent Risk	Planned Detection Risk\nYes	Yes	No\n\n', '\nControl Risk	Inherent Risk	Planned Detection Risk\nNo	No	Yes\n\n', '\nControl Risk	Inherent Risk	Planned Detection Risk\nNo	No	No\n\n', '0', '8', 'LO5'),
(152, 'Based on audit evidence gathered and evaluated, an auditor decides to increase the assessed level of control risk from that originally planned. To achieve an overall audit risk level that is substantially the same as the planned audit risk level, the auditor would\n', 'increase materiality levels.\n', 'decrease detection risk.\n', 'decrease substantive testing.\n', 'increase inherent risk.\n', '1', '8', 'LO5'),
(153, 'When dealing with audit risk,\n', 'auditors cannot accept any level of risk in performing the audit function.\n', 'most risks that auditors encounter are relatively easy to measure.\n', 'the audit risk model is only used for classes of transactions.\n', 'the audit risk model helps the auditor to decide how much and what types of evidence to accumulate.\n', '3', '8', 'LO5'),
(154, 'The measurement of the auditor\'s assessment of the susceptibility of an assertion to material misstatement, before considering the effectiveness of related internal controls is defined as\n', 'audit risk.\n', 'inherent risk.\n', 'sampling risk.\n', 'detection risk.\n', '1', '8', 'LO5'),
(155, 'The risk that audit evidence for an audit objective will fail to detect misstatements exceeding performance materiality levels is\n', 'audit risk.\n', 'control risk.\n', 'inherent risk.\n', 'planned detection risk.\n', '3', '8', 'LO5'),
(156, 'If the auditor decides to reduce acceptable audit risk, planned detection risk \n', 'increases.\n', 'decreases.\n', 'stay the same.\n', 'cannot be determined.\n', '1', '8', 'LO5'),
(157, 'Inherent risk is ________ related to planned detection risk and ________ related to the amount of audit evidence.\n', 'directly; inversely\n', 'directly; directly\n', 'inversely; inversely\n', 'inversely; directly\n', '3', '8', 'LO5'),
(158, 'Auditors frequently refer to the terms audit assurance, overall assurance, and level of assurance instead of\n', 'detection risk.\n', 'audit report risk.\n', 'acceptable audit risk.\n', 'inherent risk.\n', '2', '8', 'LO5'),
(159, 'If planned detection risk is reduced, the amount of evidence the auditor accumulates will\n', 'increase.\n', 'decrease.\n', 'remain unchanged.\n', 'be indeterminate.\n', '0', '8', 'LO5');
INSERT INTO `question_table` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `answer`, `chapter`, `LO`) VALUES
(160, 'Planned detection risk\nI.	determines the amount of substantive evidence the auditor plans to accumulate.\nII.	is dependent on inherent risk and business risk.\n', 'I only\n', 'II only\n', 'I and II\n', 'neither I nor II\n', '0', '8', 'LO5'),
(161, 'Inherent risk is often high for an account such as\n', 'inventory.\n', 'land.\n', 'capital stock.\n', 'notes payable.\n', '0', '8', 'LO5'),
(162, 'Inherent risk and control risk\n', 'are inversely related to each other.\n', 'are inversely related to detection risk.\n', 'are directly related to detection risk.\n', 'are directly related to audit risk.\n', '1', '8', 'LO5'),
(163, 'To what extent do auditors typically rely on internal controls of their public company clients?\n', 'extensively\n', 'only very little\n', 'infrequently\n', 'never\n', '0', '8', 'LO5'),
(164, 'Auditors typically rely on internal controls of their private company clients\n', 'only as needed to complete the audit and satisfy Sarbanes-Oxley requirements.\n', 'only if the controls are determined to be effective.\n', 'only if the client asks an auditor to test controls.\n', 'only if the controls are sufficient to increase control risk to an acceptable level.\n', '1', '8', 'LO5'),
(165, 'Which is a true statement about audit risk?\n', 'Audit risk measures the risk that a material misstatement could occur and not be detected by internal control.\n', 'When auditors decide on a higher acceptable audit risk, they want to be more certain that the financial statements are not materially misstated.\n', 'Audit assurance is the complement of acceptable audit risk.\n', 'There is an inverse relationship between acceptable audit risk and planned detection risk.\n', '2', '8', 'LO5'),
(166, 'The risk of material misstatement refers to\n', 'control risk and acceptable audit risk.\n', 'inherent risk.\n', 'the combination of inherent risk and control risk.\n', 'inherent risk and audit risk.\n', '2', '8', 'LO5'),
(167, 'When assessing risk, it is important to remember that\n', 'for acceptable audit risk, the SEC decides the risk the CPA firm should take for public clients.\n', 'inherent risk can be changed by the auditor.\n', 'detection risk can only be determined after audit risk, inherent risk, and control risk are determined.\n', 'control risk is determined by company management since they are responsible for internal control.\n', '2', '8', 'LO5'),
(168, 'Which of the following is a correct relationship?\n', 'Acceptable audit risk and planned detection risk have an inverse relationship.\n', 'Control risk and planned detection risk have a direct relationship.\n', 'Planned detection risk and inherent risk have an inverse relationship.\n', 'All of the above are correct relationships.\n', '2', '8', 'LO5'),
(169, 'In a financial statement audit, inherent risk is evaluated to help an auditor asses which of the following?\n', 'the internal audit department\'s objectivity in reporting a material misstatement of a financial statement assertion it detects to the audit committee\n', 'the risk the internal control system will not detect a material misstatement of a financial statement assertion\n', 'the risk that the audit procedures implemented will not detect a material misstatement of a financial statement assertion\n', 'the susceptibility of a financial statement assertion to a material misstatement assuming there are no related controls\n', '3', '8', 'LO5'),
(170, 'Which of the following statements is not true?\n', 'Inherent risk is inversely related to the amount of audit evidence whereas detection risk is directly related to the amount of audit evidence required.\n', 'Inherent risk is directly related to evidence whereas detection risk is inversely related to the amount of audit evidence required.\n', 'Inherent risk is the susceptibility of the financial statements to material error, assuming no internal controls.\n', 'Inherent risk and control risk are assessed by the auditor and function independently of the financial statement audit.\n', '0', '8', 'LO5'),
(171, 'An auditor who audits a business cycle that has low inherent risk should\n', 'increase the amount of audit evidence gathered.\n', 'assign more experienced staff to that area.\n', 'expand planning procedures.\n', 'do none of the above.\n', '3', '8', 'LO5'),
(172, 'The most important element of the audit risk model is control risk.\n', '', '', '', '', 'F', '8', 'LO5'),
(173, 'The audit risk model that must be used for planning audit procedures and evaluating audit results is: \n	 	=	AAR\n', '', '', '', '', 'F', '8', 'LO5'),
(174, 'If acceptable audit risk is low, and inherent risk and control risk are both low, then planned detection risk should be high.\n', '', '', '', '', 'T', '8', 'LO5'),
(175, 'If the audit assurance rate is 95%, then the level of acceptable audit risk is 5%.\n', '', '', '', '', 'T', '8', 'LO5'),
(176, 'A high detection risk equates to a low amount of audit evidence needed.\n', '', '', '', '', 'F', '8', 'LO5'),
(177, 'For a private company client, auditors are required to test any internal controls they believe have not been operating effectively during the period under audit.\n', '', '', '', '', 'F', '8', 'LO5'),
(178, 'There is a direct relationship between acceptable audit risk and planned detection risk.\n', '', '', '', '', 'T', '8', 'LO5'),
(179, 'Acceptable audit risk and the amount of substantive evidence required are inversely related.\n', '', '', '', '', 'T', '8', 'LO5'),
(180, 'As control risk increases, the amount of substantive evidence the auditor plans to accumulate should increase.\n', '', '', '', '', 'T', '8', 'LO5'),
(181, 'Inherent risk and control risk are directly related.\n', '', '', '', '', 'F', '8', 'LO5'),
(182, 'Audit assurance is the complement of planned detection risk, that is, one minus planned detection risk.\n', '', '', '', '', 'F', '8', 'LO5'),
(183, 'If an auditor believes the chance of financial failure is high and there is a corresponding increase in business risk for the auditor, acceptable audit risk would likely\n', 'be reduced.\n', 'be increased.\n', 'remain the same.\n', 'be calculated using a computerized statistical package.\n', '0', '8', 'LO6'),
(184, 'When management has an adequate level of integrity for the auditor to accept the engagement but cannot be regarded as completely honest in all dealings, auditors normally\n', 'reduce acceptable audit risk and increase inherent risk.\n', 'reduce inherent risk and control risk.\n', 'increase inherent risk and control risk.\n', 'increase acceptable audit risk and reduce inherent risk.\n', '0', '8', 'LO6'),
(185, 'When the auditor is attempting to determine the extent to which external users rely on a client\'s financial statements, they may consider several factors except for\n', 'client size.\n', 'concentration of ownership.\n', 'nature and amounts of liabilities.\n', 'assessment of detection risk.\n', '3', '8', 'LO6'),
(186, '________ is the risk that the auditor or audit firm will suffer harm after the audit is finished, even though the audit report was correct.\n', 'Inherent risk\n', 'Audit risk\n', 'Engagement risk\n', 'Control risk\n', '2', '8', 'LO6'),
(187, 'If an auditor believes the client will have financial difficulties after the audit report is issued, and external users will be relying heavily on the financial statements, the auditor will probably set acceptable audit risk as low.\n', '', '', '', '', 'T', '8', 'LO6'),
(188, 'Overall assessment of acceptable audit risk is highly subjective.\n', '', '', '', '', 'T', '8', 'LO6'),
(189, 'An acceptable audit risk assessment of low indicates a risky client requiring more extensive evidence, assignment of more experienced personnel, and/or a more extensive review of audit files.\n', '', '', '', '', 'T', '8', 'LO6'),
(190, 'Which of the following statements regarding inherent risk is correct?\n', 'Inherent risk is unaffected by the auditor\'s experience with client\'s organization.\n', 'Most auditors set a low inherent risk in the first year of an audit and increase it if experience shows that it was incorrect.\n', 'Most auditors set a high inherent risk in the first year of an audit and reduce it in subsequent years as they gain more knowledge about the company.\n', 'Inherent risk is dependent upon the strengths in client\'s internal control system.\n', '2', '8', 'LO7'),
(191, 'Auditors begin their assessments of inherent risk during audit planning. Which of the following would not help in assessing inherent risk during the planning phase?\n', 'obtaining client\'s agreement on the engagement letter\n', 'obtaining knowledge about the client\'s business and industry\n', 'touring the client\'s plant and offices\n', 'identifying related parties\n', '0', '8', 'LO7'),
(192, 'Which of the following is not a primary consideration when assessing inherent risk?\n', 'nature of client\'s business\n', 'existence of related parties\n', 'effectiveness of internal controls\n', 'susceptibility to misappropriation of assets\n', '2', '8', 'LO7'),
(193, 'Which of the following is an accurate statement regarding inherent risk?\n', 'The profession has established guidelines for setting inherent risk.\n', 'Auditors are generally conservative in setting inherent risk.\n', 'Factors impacting inherent risk will affect all cycles, balances, and disclosures.\n', 'Inherent risk has no impact on the amount of evidence gathered.\n', '1', '8', 'LO7'),
(194, 'The risk of fraud should be assessed for the entire audit as well as by cycle, account, and objective.\n', '', '', '', '', 'T', '8', 'LO7'),
(195, 'The auditing profession has established guidelines for setting inherent risk.\n', '', '', '', '', 'F', '8', 'LO7'),
(196, 'Accounts that require considerable judgment have a higher inherent risk.\n', '', '', '', '', 'T', '8', 'LO7'),
(197, 'Which of the following is true regarding audit risk for segments?\n', 'Control risk must be assessed at the same level for all accounts.\n', 'Factors affecting inherent risk do not differ from account to account.\n', 'Acceptable audit risk is ordinarily assessed by the auditor during the substantive test of balances phase and is held constant for each major cycle and account.\n', 'In some cases, a lower acceptable audit risk may be more appropriate for one account than for others.\n', '3', '8', 'LO8'),
(198, 'Auditors respond to risk primarily by\nI.	changing the extent of testing.\nII.	changing the types of audit procedures.\n', 'I only\n', 'II only\n', 'I and II\n', 'neither I nor II\n', '2', '8', 'LO8'),
(199, 'When using the audit risk model,\n', 'auditors find it relatively easy to measure the components of the model.\n', 'many auditors use broad and subjective measurement terms.\n', 'auditors find it easy to measure the amount of evidence implied by a given planned detection risk.\n', 'auditors are only concerned with understating accounts.\n', '1', '8', 'LO8'),
(200, 'In applying the audit risk model, auditors are concerned about overstatements, not understatements.\n', '', '', '', '', 'F', '8', 'LO8'),
(201, 'One major limitation in the application of the audit risk model is the difficulty of measuring the components of the model.\n', '', '', '', '', 'T', '8', 'LO8'),
(202, 'Since the audit risk model is a planning model, it assists the auditor in evaluating results.\n', '', '', '', '', 'F', '8', 'LO8'),
(203, 'When taken together, the concepts of risk and materiality in auditing\n', 'measure the uncertainty of amounts of a given magnitude.\n', 'measure uncertainty only.\n', 'measure magnitude only.\n', 'measure inherent risk.\n', '0', '8', 'LO9'),
(204, 'Which of the following is a correct statement?\n', 'There is no relationship between materiality and risk in auditing.\n', 'Risk is a measure of magnitude or size.\n', 'The combination of performance materiality and the audit risk model factors determines planned audit evidence.\n', 'Performance materiality is part of the audit risk model.\n', '2', '8', 'LO9'),
(205, 'Performance materiality impacts inherent risk and control risk.\n', '', '', '', '', 'F', '8', 'LO9'),
(206, 'Which of the following best defines fraud in a financial statement auditing context?\n', 'Fraud is an unintentional misstatement of the financial statements.\n', 'Fraud is an intentional misstatement of the financial statements.\n', 'Fraud is either an intentional or unintentional misstatement of the financial statements, depending on materiality.\n', 'Fraud is either an intentional or unintentional misstatement of the financial statements, depending on consistency.\n', '1', '9', 'LO1'),
(207, 'Companies may intentionally understate earnings when income is high to create ________ that may be used in future years to increase earnings. \n', 'income smoothing\n', 'cookie jar reserves\n', 'cash\n', 'sales\n', '1', '9', 'LO1'),
(208, 'Which of the following is a category of fraud?\n', '\nFraudulent financial reporting 	Misappropriation of assets\nYes	Yes\n\n', '\nFraudulent financial reporting 	Misappropriation of assets\nNo	No\n\n', '\nFraudulent financial reporting 	Misappropriation of assets\nYes	No\n\n', '\nFraudulent financial reporting 	Misappropriation of assets\nNo	Yes\n\n', '0', '9', 'LO1'),
(209, 'Most cases of fraudulent reporting involve\n', 'inadequate disclosures.\n', 'an overstatement of income.\n', 'an overstatement of liabilities.\n', 'an overstatement of expenses.\n', '1', '9', 'LO1'),
(210, '________ is fraud that involves theft of an entity\'s assets.\n', 'Fraudulent financial reporting\n', 'A \"cookie jar\" reserve\n', 'Misappropriation of assets\n', 'Income smoothing\n', '2', '9', 'LO1'),
(211, 'Which of the following is a form of earnings management in which revenues and expenses are shifted between periods to reduce fluctuations in earnings?\n', 'fraudulent financial reporting\n', 'expense smoothing\n', 'income smoothing\n', 'Each of the above is correct.\n', '2', '9', 'LO1'),
(212, 'Misappropriation of assets is normally perpetrated by\n', 'members of the board of directors.\n', 'employees at lower levels of the organization.\n', 'management of the company.\n', 'the internal auditors.\n', '1', '9', 'LO1'),
(213, 'Fraudulent financial reporting\n', 'always involves inadequate disclosures.\n', 'can be intentional or unintentional.\n', 'can involve understating net income in order to reduce income taxes.\n', 'all of the above\n', '2', '9', 'LO1'),
(214, 'According to the Association of Certified Fraud Examiners, the average company loses ________ percent of its revenues to fraud.\n', 'one\n', 'five\n', 'ten\n', 'fifteen\n', '1', '9', 'LO1'),
(215, 'Which of the following is an accurate statement regarding the misappropriation of assets?\n', 'In most cases, the amounts involved are material to the financial statements.\n', 'Misappropriation of assets can easily increase in size over time and can lead to significant reputational harm.\n', 'Management should not be concerned about minor misappropriations.\n', 'Asset misappropriation schemes are less common than fraudulent financial statement schemes.\n', '1', '9', 'LO1'),
(216, 'Fraudulent financial reporting is an intentional misstatement or omission of amounts or disclosures with the intent to deceive users.\n', '', '', '', '', 'T', '9', 'LO1'),
(217, 'The two main categories of fraud are fraudulent financial reporting and misappropriation of assets.\n', '', '', '', '', 'T', '9', 'LO1'),
(218, '\"Cookie jar reserves\" are often created by companies whenever their earnings are low to create reserves for future periods when earnings need to be \"boosted\" upward.\n', '', '', '', '', 'F', '9', 'LO1'),
(219, 'Misappropriation of assets is normally perpetrated at the lowest levels of the organization hierarchy.\n', '', '', '', '', 'T', '9', 'LO1'),
(220, 'Fraudulent financial reporting usually involves manipulation of amounts rather than disclosures.\n', '', '', '', '', 'T', '9', 'LO1'),
(221, 'According to the Association of Certified Fraud Examiners, losses from misappropriation schemes are higher than losses from financial statement frauds.\n', '', '', '', '', 'F', '9', 'LO1'),
(222, 'Which of the following are elements of the fraud triangle?\n', '\nAttitudes/rationalization	Risk Factors	Opportunities\nYes	No	Yes\n\n', '\nAttitudes/rationalization	Risk Factors	Opportunities\nNo	Yes	Yes\n\n', '\nAttitudes/rationalization	Risk Factors	Opportunities\nYes	No	No\n\n', '\nAttitudes/rationalization	Risk Factors	Opportunities\nNo	Yes	No\n\n', '0', '9', 'LO2'),
(223, 'Although the financial statements of all companies are potentially subject to manipulation, the risk is greater for companies that\n', 'are heavily regulated.\n', 'have low amounts of debt.\n', 'have to make significant judgments for accounting estimates.\n', 'operate in stable economic environments.\n', '2', '9', 'LO2'),
(224, 'Which of the following is not a factor that relates to opportunities to commit fraudulent financial reporting?\n', 'lack of controls related to the calculation and approval of accounting estimates\n', 'ineffective oversight of financial reporting by the board of directors\n', 'management\'s set of ethical values\n', 'high turnover of accounting, internal audit, and information technology staff\n', '2', '9', 'LO2'),
(225, 'Fraud is more prevalent in smaller businesses and not-for-profit organizations because it is more difficult for them to maintain\n', 'adequate separation of duties.\n', 'adequate compensation.\n', 'adequate financial reporting standards.\n', 'adequate supervisory boards.\n', '0', '9', 'LO2'),
(226, 'Which of the following is a factor that relates to incentives or pressures to commit fraudulent financial reporting?\n', 'significant accounting estimates involving subjective judgments\n', 'excessive pressure for management to meet debt repayment requirements\n', 'management\'s practice of making overly aggressive forecasts\n', 'high turnover of accounting, internal audit, and information technology staff\n', '1', '9', 'LO2'),
(227, 'Which of the following is a factor that relates to attitudes or rationalization to misappropriate assets?\n', 'significant accounting estimates involving subjective judgments\n', 'excessive pressure for management to meet debt repayment requirements\n', 'a sense of superiority by executives\n', 'high turnover of accounting, internal audit and information technology staff\n', '2', '9', 'LO2'),
(228, 'Which of the following is not a factor that relates to opportunities to misappropriate assets?\n', 'inadequate internal controls over assets\n', 'presence of large amounts of cash on hand\n', 'inappropriate segregation of duties or independent checks on performance\n', 'adverse relationships between management and employees\n', '3', '9', 'LO2'),
(229, 'Which of the following is a factor that relates to incentives/pressures to misappropriate assets?\n', 'weak internal controls\n', 'significant personal financial obligations\n', 'management\'s practice of making overly aggressive forecasts\n', 'anger and fear\n', '1', '9', 'LO2'),
(230, 'According to a KPMG survey, most fraud perpetrators\n', 'are over the age of 65.\n', 'work on the assembly line.\n', 'have worked for the company for over ten years.\n', 'are female.\n', '2', '9', 'LO2'),
(231, 'In the fraud triangle, fraudulent financial reporting and misappropriation of assets\n', 'share little in common.\n', 'share most of the same risk factors.\n', 'share the same three conditions of the fraud triangle. \n', 'share most of the same conditions. of the fraud triangle.\n', '2', '9', 'LO2'),
(232, 'Which of the following would the auditor be most concerned about regarding a heightened risk of intentional misstatement?\n', 'Senior management emphasizes that it is very important to beat analyst estimates of earnings every reporting period.\n', 'Senior management emphasizes that budgeted amounts for expenses are to be achieved for each reporting period or explained in the variance analysis report.\n', 'Senior management emphasizes that job rotation is a worthwhile corporate objective.\n', 'Senior management emphasizes that job evaluations are based on performance.\n', '0', '9', 'LO2'),
(233, 'Which of the following is a risk factor related to opportunities and financial statement fraud?\n', 'ineffective communication of company values\n', 'promotions inconsistent with expectations\n', 'significant related-party transactions\n', 'adverse relationships between management and employees\n', '2', '9', 'LO2'),
(234, 'Relating to opportunities, why do most people commit fraud?\n', 'They need to fund an extravagant lifestyle.\n', 'They feel a sense of superiority.\n', 'There are weak internal controls.\n', 'They need to meet pre-specified business targets.\n', '2', '9', 'LO2'),
(235, 'Incentives and opportunities are two conditions that are generally present when financial statement fraud occurs.\n', '', '', '', '', 'T', '9', 'LO2'),
(236, 'Fraud is more prevalent in large businesses than small businesses and not-for-profit organizations.\n', '', '', '', '', 'F', '9', 'LO2'),
(237, 'Turnover in accounting personnel can create a rationalization for misstatement.\n', '', '', '', '', 'F', '9', 'LO2'),
(238, 'A lack of controls over payments to vendors can cause revenue fraud.\n', '', '', '', '', 'F', '9', 'LO2'),
(239, 'Ineffective oversight by the board of directors over financial reporting is an example of an incentives/pressures risk factor.\n', '', '', '', '', 'F', '9', 'LO2'),
(240, 'A common incentive for companies to manipulate financial statements is a decline in the company\'s financial prospects.\n', '', '', '', '', 'T', '9', 'LO2'),
(241, 'The pressure to do \"whatever it takes\" to meet goals is one of the main reasons why financial statement fraud occurs.\n', '', '', '', '', 'T', '9', 'LO2'),
(242, 'In the fraud triangle, fraudulent financial reporting and misappropriation of assets share the same conditions and risk factors.\n', '', '', '', '', 'F', '9', 'LO2'),
(243, 'Which of the following is true statement regarding professional skepticism?\n', 'Auditors reject most potential clients perceived as lacking honesty and integrity.\n', 'If the auditor has past experience with a client, they can assume the client is honest.\n', 'Material frauds occur in most of the audits of financial statements.\n', 'Professional skepticism is required only during the planning phase.\n', '0', '9', 'LO3'),
(244, 'Upon discovering information that indicates a material misstatement due to fraud may have occurred, auditors should\n', 'acquire additional evidence as needed.\n', 'thoroughly probe the issues.\n', 'consult with other team members.\n', 'all of the above\n', '3', '9', 'LO3'),
(245, 'As part of the brainstorming sessions, auditors are directed to emphasize\n', '\nHow management could perpetrate and conceal fraudulent financial reporting	The audit team\'s response to potential fraud risks\nYes	Yes\n\n', '\nHow management could perpetrate and conceal fraudulent financial reporting	The audit team\'s response to potential fraud risks\nNo	No\n\n', '\nHow management could perpetrate and conceal fraudulent financial reporting	The audit team\'s response to potential fraud risks\nYes	No\n\n', '\nHow management could perpetrate and conceal fraudulent financial reporting	The audit team\'s response to potential fraud risks\nNo	Yes\n\n', '0', '9', 'LO3'),
(246, 'Which of the following questions is the auditor not required to ask company management when assessing fraud risk?\n', 'Does management have knowledge of any fraud or suspected fraud within the company?\n', 'What is the nature of the fraud risks identified by management?\n', 'Is management using all assets effectively?\n', 'What internal controls have been implemented to address the fraud risks?\n', '2', '9', 'LO3'),
(247, 'When assessing the risk for fraud, the auditor must be cognizant of the fact that\n', 'the existence of fraud risk factors means fraud exists.\n', 'analytical procedures must be performed on revenue accounts.\n', 'horizontal analysis is not useful in helping to determine unusual financial statement relationships.\n', 'the auditor cannot make inquiries about fraud to company personnel who have no financial statement responsibilities.\n', '1', '9', 'LO3'),
(248, 'Which of the following is not a likely source of information to assess fraud risks?\n', 'communications among audit team members\n', 'inquiries of management\n', 'analytical procedures\n', 'consideration of fraud risks discovered during recent audits of other clients\n', '3', '9', 'LO3'),
(249, 'When assessing fraud risk,\n', 'fraud risk is assessed only at the overall financial statement level.\n', 'the auditor\'s assessment of fraud risk should be ongoing throughout the audit.\n', 'if the auditor concludes that there is a risk of material misstatement due to fraud, auditing standards require that the risks be treated as pervasive.\n', 'auditing standards require that the auditor presume there is a risk of fraud in the inventory account.\n', '1', '9', 'LO3'),
(250, 'In vertical analysis, the account balance is compared to the previous period, and the percentage change for the period is calculated.\n', '', '', '', '', 'F', '9', 'LO3'),
(251, 'Information and idea exchange sessions by the audit team are required by current auditing standards.\n', '', '', '', '', 'T', '9', 'LO3'),
(252, 'Upon discovering information that indicates a material misstatement due to fraud, the auditor must assume that the misstatement is an isolated incident.\n', '', '', '', '', 'F', '9', 'LO3'),
(253, 'The presence of fraud risk factors increases the likelihood of fraud and may suggest that fraud is being perpetrated.\n', '', '', '', '', 'T', '9', 'LO3'),
(254, 'When the auditor receives inconsistent responses from management and others within the organization, the auditor should obtain additional audit evidence to resolve the inconsistency.\n', '', '', '', '', 'T', '9', 'LO3'),
(255, 'Auditing standards require that the auditor presume that there is a risk of fraud in revenue recognition.\n', '', '', '', '', 'T', '9', 'LO3'),
(256, 'For significant risks, including fraud risks, the auditor should obtain an understanding of the internal controls related to the risks.\n', '', '', '', '', 'T', '9', 'LO3'),
(257, 'Which of the following is the best reason for management to emphasize fraud prevention and deterrence?\n', 'It is often more effective and economical for companies to focus on fraud prevention and deterrence rather than on fraud detection.\n', 'Collusion is impossible to detect.\n', 'The AICPA requires management to implement a fraud prevention program.\n', 'All of the above are equally valid reasons.\n', '0', '9', 'LO4'),
(258, 'Which of the following parties is responsible for implementing internal controls to minimize the likelihood of fraud?\n', 'external auditors\n', 'audit committee members\n', 'management\n', 'Committee of Sponsoring Organizations\n', '2', '9', 'LO4'),
(259, 'Research indicates that the most effective way to prevent and deter fraud is to\n', 'implement programs and controls that are based on core values embraced by the company.\n', 'hire highly ethical employees.\n', 'communicate expectations to all employees on an annual basis.\n', 'terminate employees who are suspected of committing fraud.\n', '0', '9', 'LO4'),
(260, 'Fraud awareness training should be\n', 'broad and all-encompassing.\n', 'extensive and include details for all functional areas.\n', 'specifically related to the employee\'s job responsibility.\n', 'focused on employees understanding the importance of ethics.\n', '2', '9', 'LO4'),
(261, 'Which party has the primary responsibility to oversee an organization\'s financial reporting and internal control process?\n', 'the board of directors\n', 'the audit committee\n', 'management of the company\n', 'the financial statement auditors\n', '1', '9', 'LO4'),
(262, 'Management is responsible for\n', '\nIdentifying and measuring fraud risks 	Taking steps to mitigate identified risks\nYes	Yes\n\n', '\nIdentifying and measuring fraud risks 	Taking steps to mitigate identified risks\nNo	No\n\n', '\nIdentifying and measuring fraud risks 	Taking steps to mitigate identified risks\nYes	No\n\n', '\nIdentifying and measuring fraud risks 	Taking steps to mitigate identified risks\nNo	Yes\n\n', '0', '9', 'LO4'),
(263, 'Which of the following is not one of the elements to prevent, deter, and detect fraud according to the AICPA?\n', 'performing analytical procedures\n', 'culture of honesty and high ethics\n', 'management\'s responsibility to evaluate risks of fraud\n', 'audit committee oversight\n', '0', '9', 'LO4'),
(264, 'Who is responsible for setting the \"tone at the top\"?\n', 'management\n', 'PCAOB\n', 'audit committee\n', 'SEC\n', '0', '9', 'LO4'),
(265, 'An effective code of conduct should contain the company\'s policies regarding\n', 'conflicts of interests.\n', 'kickbacks.\n', 'gifts and entertainment.\n', 'all of the above.\n', '3', '9', 'LO4'),
(266, 'Management and the board of directors are responsible for setting the \"tone at the top.\"\n', '', '', '', '', 'T', '9', 'LO4'),
(267, 'If employees have positive feelings about their employers, they are less likely to commit fraud.\n', '', '', '', '', 'T', '9', 'LO4'),
(268, 'Management must recognize that almost any employee is capable of committing a dishonest act under the right circumstances.\n', '', '', '', '', 'T', '9', 'LO4'),
(269, 'Audit committee oversight also serves as a deterrent to fraud by senior management.\n', '', '', '', '', 'T', '9', 'LO4'),
(270, 'As part of designing and performing procedures to address management override of controls, auditors must perform which of the following procedures?\n', '\nExamine journal entries for evidence of possible misstatements due to fraud	Review accounting estimates for biases\nYes	Yes\n\n', '\nExamine journal entries for evidence of possible misstatements due to fraud 	Review accounting estimates for biases\nNo	No\n\n', '\nExamine journal entries for evidence of possible misstatements due to fraud	Review accounting estimates for biases\nYes	No\n\n', '\nExamine journal entries for evidence of possible misstatements due to fraud	Review accounting estimates for biases\nNo	Yes\n\n', '0', '9', 'LO5'),
(271, 'Auditors may identify conditions during fieldwork that change or support a judgment about the initial assessment of fraud risks. Which of the following is not a condition which should alert an auditor that the initial assessment should be changed?\n', 'The subsidiary ledger agrees with the general ledger.\n', 'discrepancies in the accounting records\n', 'unusual relationships between the auditor and management\n', 'missing or conflicting evidence\n', '0', '9', 'LO5'),
(272, 'When the auditor identifies risk at the assertion level,\n', 'the auditor may need to obtain audit evidence that is more reliable and relevant.\n', 'the auditor may choose to conduct substantive testing during interim periods rather than at the end of the period.\n', 'the auditor may decrease the sample size.\n', 'both a and b\n', '0', '9', 'LO5'),
(273, 'Because fraud perpetrators are often knowledgeable about audit procedures, auditors should incorporate unpredictability into the audit plan.\n', '', '', '', '', 'T', '9', 'LO5'),
(274, 'The auditors should pay careful attention to accounting principles that involve subjective measurements or complex transactions.\n', '', '', '', '', 'T', '9', 'LO5'),
(275, 'Auditing standards specifically require auditors to identify ________ as a fraud risk in most audits.\n', 'overstated assets\n', 'understated liabilities\n', 'revenue recognition\n', 'overstated expenses\n', '2', '9', 'LO6'),
(276, 'Company management is often under pressure to increase revenue and/or net income. One approach is to use a \"bill and hold\" arrangement. This is an example of which of the following?\n', 'significant accounting estimates\n', 'fictitious revenue recorded\n', 'premature revenue recognized\n', 'alteration of cutoff documents\n', '2', '9', 'LO6'),
(277, 'A company is concerned with the theft of cash after the sale has been recorded. One way in which fraudsters conceal the theft is by a process called \"lapping.\" Which of the following best describes lapping?\n', 'reduce the customer\'s account by recording a sales return\n', 'write off the customer\'s account\n', 'apply the payment from another customer to the customer\'s account\n', 'reduce the customer\'s account by recording a sales allowance\n', '2', '9', 'LO6'),
(278, 'Analytical procedures can be very effective in detecting inventory fraud. Which of the following analytical procedures would not be useful in detecting fraud?\n', 'gross margin percentage\n', 'inventory turnover\n', 'cost of sales percentage\n', 'accounts receivable turnover\n', '3', '9', 'LO6'),
(279, 'When dealing with revenue frauds,\n', 'the most egregious form of revenue fraud involves premature revenue recognition.\n', 'premature revenue recognition involves recognizing the revenue after the accounting standards requirements have been met.\n', 'premature revenue recognition is the same as cutoff errors.\n', 'side agreements can modify the terms of the sales transaction and should be analyzed carefully.\n', '3', '9', 'LO6'),
(280, 'Two of the most useful warning signals that can indicate that revenue fraud is occurring are\n', 'analytical procedures and documentary discrepancies.\n', 'analytical procedures and misappropriation of assets.\n', 'documentary discrepancies and vague responses to inquiries.\n', 'missing audit evidence and vague responses to inquiries.\n', '0', '9', 'LO6'),
(281, 'Fictitious revenues\n', 'increase accounts receivable turnover.\n', 'understate the gross margin percentage.\n', 'lower accounts receivable turnover.\n', 'have no impact on the gross margin percentage.\n', '2', '9', 'LO6'),
(282, 'Which of the following is a correct statement regarding the misappropriation of receipts involving revenue?\n', 'One of the easiest frauds to detect is when a sale is not recorded and the cash from the sale is stolen.\n', 'If a customer\'s payment is stolen, regular billing of unpaid accounts can uncover the fraud unless the fraud perpetrator does something to hide the theft.\n', 'Misappropriation of cash receipts is generally as material as fraudulent reporting of revenues.\n', 'Analytical procedures can detect relatively small thefts of sales and related cash receipts.\n', '1', '9', 'LO6'),
(283, 'When analyzing accounts for fraud risk,\n', 'companies will generally attempt to overstate accounts payable and net income.\n', 'the inventory account is generally not susceptible to fraud since the auditor must verify the existence of the inventory.\n', 'payroll is rarely a significant risk for fraudulent financial reporting.\n', 'fixed assets are rarely stolen because of their large size.\n', '2', '9', 'LO6'),
(284, 'When dealing with fraudulent financial reporting risk for accounts payable,\n', 'companies will generally tend to overstate accounts payable.\n', 'it is difficult for the auditor to verify if all liabilities have been recorded if prenumbered receiving reports are used.\n', 'companies have used fictitious reductions to accounts payable to overstate net income.\n', 'accounts payable is rarely a significant risk area for fraudulent financial reporting.\n', '2', '9', 'LO6'),
(285, 'Which of the following is an accurate statement regarding assets and fraud risk?\n', 'Companies will often capitalize repairs as fixed assets.\n', 'Since fixed assets are often large, there is little theft of fixed assets.\n', 'Intangible assets are recorded at cost and valuation issues therefore are not a fraud risk.\n', 'Since companies have few fixed assets, there is no need for them to be periodically inventoried.\n', '0', '9', 'LO6'),
(286, 'When the allowance for doubtful accounts is understated, bad debt expense is understated and net income is also understated.\n', '', '', '', '', 'F', '9', 'LO6'),
(287, 'Fictitious revenue transactions have the same level of documentary evidence as legitimate transactions.\n', '', '', '', '', 'F', '9', 'LO6'),
(288, 'Auditors should rely on original, rather than duplicate, copies of documents.\n', '', '', '', '', 'T', '9', 'LO6'),
(289, 'The two most common areas of fraud in payroll are the creation of fictitious employees and the overstatement of individual payroll hours.\n', '', '', '', '', 'T', '9', 'LO6'),
(290, 'To address heightened risks of fraud, the auditor can do all of the following except\n', 'use specialists to assist in evaluating the accuracy and reasonableness of management\'s key estimates.\n', 'decrease the amount of substantive tests.\n', 'use ACL or IDEA to search for fictitious revenue transactions. \n', 'use EXCEL to perform analytical procedures at the disaggregated level.\n', '1', '9', 'LO7'),
(291, 'Which of the following is least likely to uncover fraud?\n', 'external auditors\n', 'internal auditors\n', 'internal controls\n', 'management\n', '0', '9', 'LO7'),
(292, 'Which of the following is not a category of inquiry used by auditors?\n', 'assessment inquiry\n', 'declarative inquiry\n', 'interrogative inquiry\n', 'informational inquiry\n', '1', '9', 'LO7'),
(293, '________ inquiry is used to obtain information about facts and details that the auditor does not have, usually about past or current events or processes.\n', 'Assessment \n', 'Declarative \n', 'Interrogative \n', 'Informational \n', '3', '9', 'LO7'),
(294, 'An auditor uses ________ inquiry to corroborate or contradict prior information.\n', 'assessment \n', 'declarative \n', 'interrogative \n', 'informational\n', '0', '9', 'LO7'),
(295, 'When the auditor suspects that fraud may be present, auditing standards require the auditor to\n', 'terminate the engagement with sufficient notice given to the client. \n', 'issue an adverse opinion or a disclaimer of opinion.\n', 'obtain additional evidence to determine whether material fraud has occurred.\n', 're-issue the engagement letter.\n', '2', '9', 'LO7'),
(296, 'With whom should the auditor communicate whenever he or she determines that senior management fraud may be present, even if the matter might be considered inconsequential?\n', 'PCAOB\n', 'audit committee\n', 'an appropriate level of management that is at least one level above those involved\n', 'the internal auditors\n', '1', '9', 'LO7'),
(297, 'Most frauds are detected by\n', 'a confession by the fraudster.\n', 'IT controls.\n', 'law enforcement.\n', 'a tip.\n', '3', '9', 'LO7'),
(298, 'The auditor has a responsibility to notify law enforcement when fraud is suspected. \n', '', '', '', '', 'F', '9', 'LO7'),
(299, 'Most frauds are discovered by accident.\n', '', '', '', '', 'F', '9', 'LO7'),
(300, 'Interrogative inquiry is often confrontational.\n', '', '', '', '', 'T', '9', 'LO7'),
(301, 'Auditors may expand other substantive procedures to address the heightened risks of fraud.\n', '', '', '', '', 'T', '9', 'LO7'),
(302, 'Auditing standards require that auditors document\n', 'specific risks of fraud identified at the financial statement level, but not at the assertion level.\n', 'all conversations with management.\n', 'results of the procedures performed to address the risk of management override of controls.\n', 'all of the above.\n', '2', '9', 'LO8'),
(303, 'If auditors determine that there is not a significant risk of material improper revenue recognition, no documentation of this decision is required.\n', '', '', '', '', 'F', '9', 'LO8'),
(304, 'Which of the following is not one of the three primary objectives of effective internal control?\n', 'reliability of financial reporting\n', 'efficiency and effectiveness of operations\n', 'compliance with laws and regulations\n', 'assurance of elimination of business risk\n', '3', '10', 'LO1'),
(305, 'With which of management\'s assertions with respect to implementing internal controls is the auditor primarily concerned?\n', 'efficiency of operations\n', 'reliability of financial reporting\n', 'effectiveness of operations\n', 'compliance with applicable laws and regulations\n', '1', '10', 'LO1'),
(306, 'Internal controls\n', 'are implemented by and are the responsibility of the auditors.\n', 'consist of policies and procedures designed to provide reasonable assurance that the company achieves its objectives and goals.\n', 'guarantee that the company complies with all laws and regulations.\n', 'only apply to SEC companies.\n', '1', '10', 'LO1'),
(307, 'Internal controls are not designed to provide reasonable assurance that\n', 'all frauds will be detected.\n', 'transactions are executed in accordance with management\'s authorization.\n', 'the company\'s resources are used efficiently and effectively.\n', 'company personnel comply with applicable rules and regulations.\n', '0', '10', 'LO1'),
(308, 'Section 404 of the Sarbanes-Oxley Act requires that both private and public companies issue an internal control report.\n', '', '', '', '', 'F', '10', 'LO1'),
(309, 'Management has a legal and professional responsibility to be sure that the financial statements are prepared in accordance with reporting requirements of applicable accounting frameworks. \n', '', '', '', '', 'T', '10', 'LO1'),
(310, 'Who is responsible for establishing a private company\'s internal control?\n', 'senior management\n', 'internal auditors\n', 'FASB\n', 'audit committee\n', '0', '10', 'LO2'),
(311, 'Two key concepts that underlie management\'s design and implementation of internal control are\n', 'costs and materiality.\n', 'absolute assurance and costs.\n', 'inherent limitations and reasonable assurance.\n', 'collusion and materiality.\n', '2', '10', 'LO2'),
(312, 'The PCAOB places responsibility for the reliability of internal controls over the financial reporting process on\n', 'the company\'s board of directors.\n', 'the audit committee of the board of directors.\n', 'management.\n', 'the CFO and the independent auditors.\n', '2', '10', 'LO2'),
(313, 'Which of the following parties provides an assessment of the effectiveness of internal control over financial reporting for public companies?\n', '\nManagement 	Financial statement auditors\nYes	Yes\n\n', '\nManagement 	Financial statement auditors\nNo	No\n\n', '\nManagement 	Financial statement auditors\nYes	No\n\n', '\nManagement 	Financial statement auditors\nNo	Yes\n\n', '0', '10', 'LO2'),
(314, 'An act of two or more employees to steal assets and cover their theft by misstating the accounting records would be referred to as\n', 'collusion.\n', 'a material weakness.\n', 'a control deficiency.\n', 'a significant deficiency.\n', '0', '10', 'LO2'),
(315, 'Sarbanes-Oxley requires management to issue an internal control report that includes two specific items. Which of the following is one of these two requirements?\n', 'a statement that management is responsible for establishing and maintaining an adequate internal control structure and procedures for financial reporting\n', 'a statement that management and the board of directors are jointly responsible for establishing and maintaining an adequate internal control structure and procedures for financial reporting\n', 'a statement that management, the board of directors, and the external auditors are jointly responsible for establishing and maintaining an adequate internal control structure and procedures for financial reporting\n', 'a statement that the external auditors are solely responsible for establishing and maintaining an adequate system of internal control\n', '0', '10', 'LO2'),
(316, 'When management is evaluating the design of internal control, management evaluates whether the control can do which of the following?\n', '\nDetect material misstatements	Correct material misstatements\nYes	Yes\n\n', '\nDetect material misstatements	Correct material misstatements\nNo	No\n\n', '\nDetect material misstatements	Correct material misstatements\nYes	No\n\n', '\nDetect material misstatements	Correct material misstatements\nNo	Yes\n\n', '2', '10', 'LO2'),
(317, 'When one material weakness is present at the end of the year, management of a public company must conclude that internal control over financial reporting is\n', 'insufficient.\n', 'inadequate.\n', 'ineffective.\n', 'inefficient.\n', '2', '10', 'LO2'),
(318, 'The auditors primary purpose in auditing the client\'s system of internal control over financial reporting is\n', 'to prevent fraudulent financial statements from being issued to the public.\n', 'to evaluate the effectiveness of the company\'s internal controls over all relevant assertions in the financial statements.\n', 'to report to management that the internal controls are effective in preventing misstatements from appearing on the financial statements.\n', 'to efficiently conduct the Audit of Financial Statements.\n', '1', '10', 'LO2'),
(319, 'The internal control framework used by most U.S. companies is the ________ framework.\n', 'FASB\n', 'PCAOB\n', 'COSO\n', 'SEC\n', '2', '10', 'LO2'),
(320, 'In performing the audit of internal control over financial reporting, the auditor emphasizes internal control over classes of transactions because\n', 'the accuracy of accounting system outputs depends heavily on the accuracy of inputs and processing.\n', 'the class of transaction is where most fraud schemes occur.\n', 'account balances are less important to the auditor then the changes in the account balances.\n', 'classes of transactions tests are the most efficient manner to compensate for inherent risk.\n', '0', '10', 'LO2'),
(321, 'Internal controls can never be regarded as completely effective. Even if company personnel could design an ideal system, its effectiveness depends on the\n', 'adequacy of the computer system.\n', 'proper implementation by management.\n', 'ability of the internal audit staff to maintain it.\n', 'competency and dependability of the people using it.\n', '3', '10', 'LO2'),
(322, 'When considering internal controls,\n', 'auditors can ignore controls affecting internal management information.\n', 'auditors are concerned with the client\'s internal controls over the safeguarding of assets if they affect the financial statements.\n', 'management is responsible for understanding and testing internal control over financial reporting.\n', 'companies must use the COSO framework to establish internal controls.\n', '1', '10', 'LO2'),
(323, 'Of the following statements about internal controls, which one is least likely to be correct?\n', 'No one person should be responsible for the custodial responsibility and the recording responsibility for an asset.\n', 'Transactions must be properly authorized before such transactions are processed.\n', 'Because of the cost-benefit relationship, a client may apply controls on a test basis.\n', 'Control procedures reasonably ensure that collusion among employees cannot occur.\n', '3', '10', 'LO2'),
(324, 'The Sarbanes-Oxley Act requires\n', 'all public companies to issue reports on internal controls.\n', 'all public companies to define adequate internal controls.\n', 'the auditor of public companies to design effective internal controls.\n', 'the auditor of public companies to withdraw from an engagement if internal controls are weak.\n', '0', '10', 'LO2'),
(325, 'Which of the following is an accurate statement regarding the auditor\'s responsibility for understanding internal control?\n', 'Transaction-related audit objectives typically have no impact on the rights and obligations objectives.\n', 'Transaction-related audit objectives typically have a significant impact on the balance-related audit objective of realizable value.\n', 'Auditors generally emphasize internal control over account balances rather than classes of transactions.\n', 'Auditors and management are both equally concerned about controls that affect the efficiency and effectiveness of company operations.\n', '0', '10', 'LO2'),
(326, 'The primary emphasis by auditors is on controls over\n', 'classes of transactions.\n', 'account balances.\n', 'both A and B, because they are equally important.\n', 'both A and B, because they vary from client to client.\n', '0', '10', 'LO2'),
(327, 'An auditor should consider two key issues when obtaining an understanding of a client\'s internal controls. These issues are\n', 'the effectiveness and efficiency of the controls.\n', 'the frequency and effectiveness of the controls.\n', 'the design and operating effectiveness of the controls.\n', 'the implementation and operating effectiveness of the controls.\n', '2', '10', 'LO2'),
(328, 'Reasonable assurance allows for\n', 'low likelihood that material misstatements will not be prevented or detected by internal controls.\n', 'no likelihood that material misstatements will not be prevented or detected by internal control.\n', 'moderate likelihood that material misstatements will not be prevented or detected by internal control.\n', 'high likelihood that material misstatements will not be prevented or detected by internal control.\n', '0', '10', 'LO2'),
(329, 'Which of the following is most correct regarding the requirements under Section 404 of the Sarbanes-Oxley Act?\n', 'The audits of internal control and the financial statements provide reasonable assurance as to misstatements.\n', 'The audit of internal control provides absolute assurance of misstatement.\n', 'The audit of financial statements provides absolute assurance of misstatement.\n', 'The audits of internal control and the financial statements provide absolute assurance as to misstatements.\n', '0', '10', 'LO2'),
(330, 'Under the Dodd-Frank federal financial reform legislation, all public companies are required to obtain an audit report on internal control over financial reporting.\n', '', '', '', '', 'F', '10', 'LO2'),
(331, 'When a company designs and implements internal controls, cost of the controls is not a valid consideration.\n', '', '', '', '', 'F', '10', 'LO2');
INSERT INTO `question_table` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `answer`, `chapter`, `LO`) VALUES
(332, 'Which of the following activities would be least likely to strengthen a company\'s internal control?\n', 'separating accounting from other financial operations\n', 'maintaining insurance for fire and theft\n', 'fixing responsibility for the performance of employee duties\n', 'carefully selecting and training employees\n', '1', '10', 'LO3'),
(333, 'Which of the following components of the control environment define the existing lines of responsibility and authority?\n', 'organizational structure\n', 'management philosophy and operating style\n', 'human resource policies and practices\n', 'management integrity and ethical values\n', '0', '10', 'LO3'),
(334, 'Which of the following factors may increase risks to an organization?\n', '\nGeographic dispersion of \ncompany operations 	Presence of new information technologies\nYes	Yes\n\n', '\nGeographic dispersion of \ncompany operations 	Presence of new information technologies\nNo	No\n\n', '\nGeographic dispersion of \ncompany operations 	Presence of new information technologies\nYes	No\n\n', '\nGeographic dispersion of \ncompany operations 	Presence of new information technologies\nNo	Yes\n\n', '0', '10', 'LO3'),
(335, 'Which of the following statements is most correct with respect to separation of duties?\n', 'A person who has temporary or permanent custody of an asset should account for that asset.\n', 'Employees who authorize transactions should not have custody of related assets.\n', 'Employees who open cash receipts should record the amounts in the subsidiary ledgers.\n', 'Employees who authorize transactions should have recording responsibility for these transactions.\n', '1', '10', 'LO3'),
(336, 'Authorizations can be either general or specific. Which of the following is not an example of a general authorization?\n', 'automatic reorder points for raw materials inventory\n', 'a sales manager\'s authorization for a sales return\n', 'credit limits for various classes of customers\n', 'a sales price list for merchandise\n', '1', '10', 'LO3'),
(337, 'Which of the following is correct with respect to the design and use of business documents?\n', 'The documents should be in paper format.\n', 'Documents should be designed for a single purpose to avoid confusion in their use.\n', 'Documents should be designed to be understandable only by those who use them.\n', 'Documents should be prenumbered consecutively to facilitate control over missing documents.\n', '3', '10', 'LO3'),
(338, 'Which of the following best describes the purpose of control activities?\n', 'the actions, policies and procedures that reflect the overall attitudes of management\n', 'the identification and analysis of risks relevant to the preparation of financial statements\n', 'the policies and procedures that help ensure that necessary actions are taken to address risks to the achievement of the entity\'s objectives\n', 'activities that deal with the ongoing assessment of the quality of internal control by management\n', '2', '10', 'LO3'),
(339, 'Which of the following deals with ongoing or periodic assessment of the quality of internal control by management?\n', 'verifying activities\n', 'monitoring activities\n', 'oversight activities\n', 'management activities\n', '1', '10', 'LO3'),
(340, 'Which of the following best describes an entity\'s accounting information and communication system?\n', '\nMonitor \ntransactions	Record and \nprocess \ntransactions	Initiate transactions\nYes	Yes	Yes\n\n', '\nMonitor \ntransactions	Record and \nprocess \ntransactions	Initiate transactions\nNo	No	No\n\n', '\nMonitor \ntransactions	Record and \nprocess \ntransactions	Initiate transactions\nYes	No	No\n\n', '\nMonitor \ntransactions	Record and \nprocess \ntransactions	Initiate transactions\nNo	Yes	Yes\n\n', '3', '10', 'LO3'),
(341, 'Which of the following is a risk assessment principle?\n', 'accountability\n', 'use relevant, quality information to support the functioning of internal controls\n', 'consider the potential for fraud\n', 'develop general controls over technology\n', '2', '10', 'LO3'),
(342, 'Which of the following is not an underlying principle related to risk assessment?\n', 'The organization should have clear objectives in order to be able to identify and assess the risks relating to the objectives.\n', 'The auditors should determine how the company\'s risks should be managed.\n', 'The organization should consider the potential for fraudulent behavior.\n', 'The organization should monitor changes that could impact internal controls.\n', '1', '10', 'LO3'),
(343, 'Which of the following is not one of the subcomponents of the control environment?\n', 'management\'s philosophy and operating style\n', 'organizational structure\n', 'adequate separation of duties\n', 'commitment to competence\n', '2', '10', 'LO3'),
(344, 'It is important for the CPA to consider the competence of the clients\' personnel because their competence has a direct impact upon the\n', 'cost/benefit relationship of the system of internal control.\n', 'achievement of the objectives of internal control.\n', 'comparison of recorded accountability with assets.\n', 'timing of the tests to be performed.\n', '1', '10', 'LO3'),
(345, 'Proper segregation of functional responsibilities calls for separation of\n', 'authorization, execution, and payment.\n', 'authorization, recording, and custody.\n', 'custody, execution, and reporting.\n', 'authorization, payment, and recording.\n', '1', '10', 'LO3'),
(346, 'Without an effective ________, the other components of the COSO framework are unlikely to result in effective internal control, regardless of their quality.\n', 'risk assessment policy\n', 'monitoring policy\n', 'control environment\n', 'system of control activities\n', '2', '10', 'LO3'),
(347, 'Which of the following is an accurate statement regarding control activities?\n', 'As the level of complexity of IT systems increases, the separation of duties often becomes blurred.\n', 'Segregation of duties would be violated if the same person authorizes the payment of a vendor\'s invoice and also approves the disbursement of funds to pay the bill.\n', 'The most important type of protective measure for safeguarding assets and records is the us of physical precautions.\n', 'all of the above\n', '3', '10', 'LO3'),
(348, 'If a company has an effective internal audit department,\n', 'the internal auditors can express an opinion on the fairness of the financial statements.\n', 'their work cannot be used by the external auditors per PCAOB Standard 5.\n', 'it can reduce external audit costs by providing direct assistance to the external auditors.\n', 'the internal auditors must be CPAs in order for the external auditors to rely on their work.\n', '2', '10', 'LO3'),
(349, 'To promote operational efficiency, the internal audit department would ideally report to\n', 'line management.\n', 'the PCAOB.\n', 'the Chief Accounting Officer.\n', 'the audit committee.\n', '3', '10', 'LO3'),
(350, 'Hanlon Corp. maintains a large internal audit staff that reports directly to the accounting department. Audit reports prepared by the internal auditors indicate that the system is functioning as it should and that the accounting records are reliable. An independent auditor will probably\n', 'eliminate tests of controls.\n', 'increase the depth of the study and evaluation of administrative controls.\n', 'avoid duplicating the work performed by the internal audit staff.\n', 'place limited reliance on the work performed by the internal audit staff.\n', '3', '10', 'LO3'),
(351, 'External financial statement auditors must obtain evidence regarding what attributes of an internal audit (I', 'department if the external auditors intend to rely on IA\'s work?\nA) integrity\n', 'objectivity\n', 'competence\n', 'all of the above\n', '3', '10', 'LO3'),
(352, 'To obtain an understanding of an entity\'s control environment, an auditor should concentrate on the substance of management\'s policies and procedures rather than their form because\n', 'management may establish appropriate policies and procedures but not act on them.\n', 'the board of directors may not be aware of management\'s attitude toward the control environment.\n', 'the auditor may believe that the policies and procedures are inappropriate for that particular entity.\n', 'the policies and procedures may be so weak that no reliance is contemplated by the auditor.\n', '0', '10', 'LO3'),
(353, 'The ________ is helpful in preventing classification errors if it accurately describes which type of transaction should be in each account.\n', 'general ledger\n', 'general journal\n', 'trial balance\n', 'chart of accounts\n', '3', '10', 'LO3'),
(354, 'Control activities are a subcomponent of the information and communication component of internal control.\n', '', '', '', '', 'F', '10', 'LO3'),
(355, 'Adequate documents and records is a subcomponent of the control environment.\n', '', '', '', '', 'F', '10', 'LO3'),
(356, 'The chart of accounts is helpful in preventing classification errors if it accurately describes which type of transaction should be in each account.\n', '', '', '', '', 'T', '10', 'LO3'),
(357, 'Auditing standards prohibit reliance on the work of internal auditors due to the lack of independence of the internal auditors.\n', '', '', '', '', 'F', '10', 'LO3'),
(358, 'If an auditor wishes to rely on the work of internal auditors (IA), the auditor must obtain satisfactory evidence related to the IA\'s competence, integrity, and objectivity.\n', '', '', '', '', 'T', '10', 'LO3'),
(359, 'An example of a specific authorization is management setting a policy authorizing the ordering of inventory when less than a one-week supply is on hand.\n', '', '', '', '', 'F', '10', 'LO3'),
(360, 'Personnel responsible for performing internal verification procedures must be independent of those originally responsible for preparing the data.\n', '', '', '', '', 'T', '10', 'LO3'),
(361, 'Old and new systems operating simultaneously in all locations is a test approach known as\n', 'pilot testing.\n', 'horizontal testing.\n', 'integrative testing.\n', 'parallel testing. \n', '3', '10', 'LO4'),
(362, 'Which of the following is a component of general controls?\n', 'processing controls\n', 'output controls\n', 'back-up and contingency planning\n', 'input controls\n', '2', '10', 'LO4'),
(363, 'Which of the following statements related to application controls is correct?\n', 'Application controls relate to various aspects of the IT function including software acquisition and the processing of transactions.\n', 'Application controls relate to various aspects of the IT function including physical security and the processing of transactions in various cycles.\n', 'Application controls relate to all aspects of the IT function.\n', 'Application controls relate to the processing of individual transactions.\n', '3', '10', 'LO4'),
(364, 'General controls include all of the following except\n', 'systems development.\n', 'online security.\n', 'processing controls.\n', 'hardware controls.\n', '2', '10', 'LO4'),
(365, 'Which of the following describes the process of implementing a new system in one part of the organization, while other locations continue to use the current system?\n', 'parallel testing\n', 'online testing\n', 'pilot testing\n', 'control testing \n', '2', '10', 'LO4'),
(366, 'A ________ is responsible for controlling the use of computer programs, transaction files and other computer records and documentation and releases them to the operators only when authorized.\n', 'software engineer\n', 'chief computer operator\n', 'librarian\n', 'data control operator \n', '2', '10', 'LO4'),
(367, 'Security controls should require that users enter a(n) ________ before being allowed access to software and other related data files.\n', 'echo check\n', 'parity check\n', 'self-diagnosis test\n', 'authorized password\n', '3', '10', 'LO4'),
(368, 'Typical controls developed for manual systems which are still important in IT systems include\n', 'management\'s authorization of transactions.\n', 'competent personnel.\n', 'adequate preparation of input source documents.\n', 'all of the above. \n', '3', '10', 'LO4'),
(369, 'Which of the following controls prevent and detect errors while transaction data are processed?\n', 'software\n', 'application\n', 'processing\n', 'transaction\n', '2', '10', 'LO4'),
(370, 'When purchasing software or developing in-house software,\n', 'cost should be the only factor.\n', 'extensive testing of the software is generally not required.\n', 'a team of both IT and non-IT personnel should be involved in the decision process.\n', 'the librarian and the IT manager should be the only ones involved in the decision process.\n', '2', '10', 'LO4'),
(371, 'Output controls need to be designed for which of the following data integrity objectives?\n', 'detecting errors after the processing is completed\n', 'preventing errors before the processing is completed\n', 'detecting errors in the general ledger adjustment process\n', 'preventing errors in separation of duties for IT personnel\n', '0', '10', 'LO4'),
(372, 'A control that relates to all parts of the IT system is called a(n)\n', 'general control.\n', 'systems control.\n', 'universal control.\n', 'applications control.\n', '0', '10', 'LO4'),
(373, 'Controls that are designed for each software application and are intended to help a company satisfy the transaction-related audit objectives are\n', 'user controls.\n', 'general controls.\n', 'audit controls.\n', 'application controls.\n', '3', '10', 'LO4'),
(374, 'Which of the following is not an example of an applications control?\n', 'Back-up of data is made to a remote site for data security.\n', 'There is a preprocessing authorization of the sales transactions.\n', 'There are reasonableness tests for the unit selling price of a sale.\n', 'After processing, all sales transactions are reviewed by the sales department.\n', '0', '10', 'LO4'),
(375, 'Which of the following is not a general control?\n', 'Computer performed validation tests of input accuracy.\n', 'Equipment failure causes error messages on monitor.\n', 'There is a separation of duties between programmer and operators.\n', 'There are adequate program run instructions for operating the computer.\n', '0', '10', 'LO4'),
(376, 'Controls which are built in by the manufacturer to detect equipment failure are called\n', 'input controls.\n', 'data integrity controls.\n', 'hardware controls.\n', 'manufacturer\'s controls.\n', '2', '10', 'LO4'),
(377, 'Controls which are designed to assure that the information entered into the computer is authorized, complete, and accurate are called\n', 'input controls.\n', 'processing controls.\n', 'output controls.\n', 'general controls.\n', '0', '10', 'LO4'),
(378, 'When dealing with the administration of the IT function and the segregation of IT duties\n', 'in large organizations, management should assign technology issues to outside consultants.\n', 'programmers should investigate all security breaches.\n', 'the board of directors should not get involved in IT decisions since it is a routine function handled by middle management.\n', 'in complex environments, management may establish IT steering committees.\n', '3', '10', 'LO4'),
(379, 'Which of the following tests determines that every field in a record has been completed?\n', 'validation\n', 'sequence\n', 'completeness\n', 'programming\n', '2', '10', 'LO4'),
(380, 'An example of a physical control is\n', 'a hash total.\n', 'a parallel test.\n', 'the matching of employee fingerprints to a database before access to the system is allowed.\n', 'the use of backup generators to prevent data loss during power outages.\n', '2', '10', 'LO4'),
(381, 'Controls specific to IT include all of the following except for\n', 'adequately designed input screens.\n', 'pull-down menu lists.\n', 'validation tests of input accuracy.\n', 'separation of duties.\n', '3', '10', 'LO4'),
(382, 'An internal control deficiency occurs when computer personnel\n', 'participate in computer software acquisition decisions.\n', 'design flowcharts and narratives for computerized systems.\n', 'originate changes in customer master files.\n', 'provide physical security over program files.\n', '2', '10', 'LO4'),
(383, 'Which of the following best explains the relationship between general controls and application controls?\n', 'Application controls are effective even if general controls are extremely weak.\n', 'Application controls are likely to be effective only when general controls are effective.\n', 'General controls have no impact on application controls.\n', 'None of the above\n', '1', '10', 'LO4'),
(384, 'A(n) ________ total represents the summary total of codes from all records in a batch that do not represent a meaningful total.\n', 'record \n', 'hash \n', 'output \n', 'financial\n', '1', '10', 'LO4'),
(385, 'In an IT system, automated equipment controls or hardware controls are designed to\n', 'correct errors in the computer programs. \n', 'monitor and detect errors in source documents.\n', 'detect and control errors arising from the use of equipment.\n', 'arrange data in a logical sequential manner for processing purposes.\n', '2', '10', 'LO4'),
(386, 'If a control total were to be computed on each of the following data items, which would best be identified as a hash total for a payroll IT application?\n', 'gross wages earned\n', 'employee numbers\n', 'total hours worked\n', 'total debit amounts and total credit amounts\n', '1', '10', 'LO4'),
(387, 'Which of the following is not an application control?\n', 'reprocessing authorization of sales transactions\n', 'reasonableness test for unit selling price of sale\n', 'post-processing review of sales transactions by the sales department\n', 'logging in to the company\'s information systems via a password\n', '3', '10', 'LO4'),
(388, 'Which of the following is not a general control?\n', 'separation of IT duties\n', 'systems development\n', 'processing controls\n', 'hardware controls\n', '2', '10', 'LO4'),
(389, '________ is the information technology and internal control processes an organization has in place to protect computers, networks, programs, and data from unauthorized access.\n', 'Encryption\n', 'A firewall\n', 'Cybersecurity\n', 'A processing control\n', '2', '10', 'LO4'),
(390, 'The most important output control is\n', 'distribution control, which assures that only authorized personnel receive the reports generated by the system.\n', 'review of data for reasonableness by someone who knows what the output should look like.\n', 'control totals, which are used to verify that the computer\'s results are correct.\n', 'logic tests, which verify that no mistakes were made in processing.\n', '1', '10', 'LO4'),
(391, 'Parallel testing is used when old and new systems are operated simultaneously in all locations.\n', '', '', '', '', 'T', '10', 'LO4'),
(392, 'Programmers should only be allowed to work with test copies of programs and data.\n', '', '', '', '', 'T', '10', 'LO4'),
(393, 'In IT systems, if general controls are effective, it increases the auditor\'s ability to rely on application controls to reduce control risk.\n', '', '', '', '', 'T', '10', 'LO4'),
(394, 'Parallel testing can be used in combination with pilot testing to test new systems.\n', '', '', '', '', 'T', '10', 'LO4'),
(395, 'The effectiveness of automated controls depends solely on the competence of the personnel performing the controls.\n', '', '', '', '', 'F', '10', 'LO4'),
(396, 'Backup and contingency plans should also identify alternative hardware that can be used to process company data.\n', '', '', '', '', 'T', '10', 'LO4'),
(397, 'A large portion of errors in IT systems result from data entry errors.\n', '', '', '', '', 'T', '10', 'LO4'),
(398, 'Output controls focus on preventing errors during processing.\n', '', '', '', '', 'F', '10', 'LO4'),
(399, 'Processing controls are a category of application controls.\n', '', '', '', '', 'T', '10', 'LO4'),
(400, 'Controls that relate to a specific use of the IT system, such as the processing of sales or cash receipts, are called application controls.\n', '', '', '', '', 'T', '10', 'LO4'),
(401, 'IT controls are classified as either input controls or output controls.\n', '', '', '', '', 'F', '10', 'LO4'),
(402, 'A database management system\n', 'allows clients to create databases that include information that can be shared across multiple applications.\n', 'stores data on different files for different purposes, but always knows where they are and how to retrieve them.\n', 'allows quick retrieval of data, but at a cost of inefficient use of file space.\n', 'allows quick retrieval of data, but it needs to update files continually. \n', '0', '10', 'LO5'),
(403, 'When auditing a client who uses a database management system, the auditor is principally aware of elevated risk due to the fact that\n', 'multiple users can access and update data files.\n', 'the accounting information is only in one place.\n', 'the database administrator may lack appropriate accounting knowledge.\n', 'multiple users could all access the data simultaneously causing a system shutdown.\n', '0', '10', 'LO5'),
(404, 'Firewalls are used to protect from\n', 'erroneous internal handling of data.\n', 'insufficient documentation of transactions.\n', 'illogical programming commands.\n', 'unauthorized external users.\n', '3', '10', 'LO5'),
(405, 'What tools do companies use to limit access to sensitive company data?\n', '\nEncryption techniques	Digital signatures	Firewall\nYes	Yes	Yes\n\n', '\nEncryption techniques	Digital signatures	Firewall\nYes	No	No\n\n', '\nEncryption techniques	Digital signatures	Firewall\nNo	Yes	Yes\n\n', '\nEncryption techniques	Digital signatures	Firewall\nYes	Yes	No\n\n', '0', '10', 'LO5'),
(406, 'Rather than maintain an internal IT center, many companies outsource their basic IT functions such as payroll to an\n', 'external general service provider.\n', 'independent computer service center.\n', 'internal control service provider.\n', 'internal auditor.\n', '1', '10', 'LO5'),
(407, 'When the auditor is obtaining an understanding of the independent computer service center\'s internal controls, the auditor should\n', 'use the same criteria used to evaluate the client\'s internal controls.\n', 'use different criteria because the service center resides outside the company.\n', 'use the same criteria used to evaluate the client\'s internal controls but omit tests of transactions.\n', 'use different criteria for the service center by including substantive tests of balances.\n', '0', '10', 'LO5'),
(408, '________ protect(s) the security of electronic communication when information is transmitted and when it is stored.\n', 'Firewalls\n', 'Digital signatures\n', 'Encryption\n', 'A database\n', '2', '10', 'LO5'),
(409, 'A(n) ________ is a computer resource deployment and procurement model that enables an organization to obtain IT resources and applications from any location via an Internet connection.\n', 'application service provider\n', 'firewall\n', 'cloud computing environment\n', 'local area network\n', '2', '10', 'LO5'),
(410, 'Firewalls can protect company data and software programs.\n', '', '', '', '', 'T', '10', 'LO5'),
(411, 'LANs link equipment within a single or small cluster of buildings and are used within a company.\n', '', '', '', '', 'T', '10', 'LO5'),
(412, 'Companies using e-commerce systems to transact business electronically do not need to be concerned about how their e-commerce partners manage IT systems risks.\n', '', '', '', '', 'F', '10', 'LO5'),
(413, 'When the auditor attempts to understand the operation of the accounting system by tracing a few transactions through the accounting system, the auditor is said to be\n', 'tracing.\n', 'vouching.\n', 'performing a walkthrough.\n', 'testing controls.\n', '2', '11', 'LO1'),
(414, 'For financial statement audits, auditors need to understand controls that are relevant to the audit in order to\n', 'identify and assess the risks of material misstatements.\n', 'perform preliminary analytical procedures.\n', 'detect fraud.\n', 'assess inherent risk.\n', '0', '11', 'LO1'),
(415, 'Narratives, flowcharts, and internal control questionnaires are three common methods of\n', 'testing the internal controls.\n', 'documenting the auditor\'s understanding of internal controls.\n', 'designing the audit manual and procedures.\n', 'documenting the auditor\'s understanding of a client\'s organizational structure.\n', '1', '11', 'LO1'),
(416, 'When dealing with the documentation of internal control,\n', 'in a narrative, most questions simply require a \"yes\" or \"no\" response.\n', 'questionnaires offer useful checklists to remind the auditor of the many different types of internal controls that should exist.\n', 'questionnaires and flowcharts should not be used together.\n', 'flowcharts fail to show the segregation of duties in the company.\n', '1', '11', 'LO1'),
(417, 'Which type of evidence is not used by the auditor to obtain an understanding of the design and implementation of internal control?\n', 'inquiry\n', 'observation\n', 'confirmation\n', 'inspection\n', '2', '11', 'LO1'),
(418, 'Walkthroughs combine observation, inspection, and inquiry to assure that the controls designed by management have been implemented.\n', '', '', '', '', 'T', '11', 'LO1'),
(419, 'A narrative should describe the disposition of every document and record in the system.\n', '', '', '', '', 'T', '11', 'LO1'),
(420, 'Flowcharts are harder to read aad update than narratives.\n', '', '', '', '', 'F', '11', 'LO1'),
(421, 'When documenting their understanding of a client\'s internal controls, auditors are required to use narratives.\n', '', '', '', '', 'F', '11', 'LO1'),
(422, 'When making a preliminary assessment of control risk, the starting point for most auditors is\n', 'IT assessment controls.\n', 'assessment of entity level controls.\n', 'transaction-related controls.\n', 'fraud controls.\n', '1', '11', 'LO2'),
(423, 'You are performing the audit of internal control for Clifton Company. Which of the following would represent a material weakness in internal control?\n', 'The company\'s audit committee has experienced unusual turnover of members.\n', 'The company\'s CFO was indicted for embezzling from the company.\n', 'Bank reconciliations are done monthly.\n', 'The CEO retired after twenty years of service to the company.\n', '1', '11', 'LO2'),
(424, 'The employee in charge of authorizing credit to the company\'s customers does not fully understand the concept of credit risk. This lack of knowledge would\n', 'constitute a deficiency in operation of internal controls.\n', 'constitute a deficiency in design of internal controls.\n', 'constitute a deficiency of management.\n', 'not constitute a deficiency.\n', '0', '11', 'LO2'),
(425, 'When assessing whether the financial statements are auditable, the auditor must consider\n', 'that the integrity of management and the adequacy of accounting records are the two primary factors determining auditability.\n', 'that the integrity of management and the adequacy of risk management are the two primary factors determining auditability.\n', 'that if all of the transaction information is available only in electronic form without a visible audit trail, the company cannot be audited.\n', 'the control risk before determining if the entity is auditable.\n', '0', '11', 'LO2'),
(426, 'Once auditors determine that entity level controls are designed and placed in the operation, they\n', 'make a preliminary assessment for each transaction-related audit objective for each major type of transaction.\n', 'make a preliminary assessment of control risk.\n', 'obtain an understanding of the design and implementation of internal control.\n', 'prepare audit documentation in order to express their opinion on the company\'s internal control system.\n', '0', '11', 'LO2'),
(427, 'Which of the following is the correct definition of \"control deficiency\"?\n', 'A control deficiency exists if the design or operation of controls does not permit company personnel to prevent or detect misstatements on a timely basis.\n', 'A control deficiency exists if one or more deficiencies exist that adversely affect a company\'s ability to prepare external financial statements reliably.\n', 'A control deficiency exists if the design or operation of controls results in a more than remote likelihood that controls will not prevent or detect misstatements.\n', 'A control deficiency exists if the design or operation of controls results in a more than probable likelihood that controls will prevent or detect misstatements.\n', '0', '11', 'LO2'),
(428, 'Which deficiency exists if a necessary control is missing or not properly implemented?\n', 'control\n', 'significant\n', 'design\n', 'operating\n', '2', '11', 'LO2'),
(429, 'To determine if significant internal control deficiencies are material weaknesses, they must be evaluated on their\n', '\nLikelihood	Significance\nYes	Yes\n\n', '\nLikelihood	Significance\nNo	No\n\n', '\nLikelihood	Significance\nYes	No\n\n', '\nLikelihood	Significance\nNo	Yes\n\n', '0', '11', 'LO2'),
(430, 'The auditor should identify and include only ________ controls since they will be sufficient to achieve the transaction-related audit objectives and will also provide audit efficiency.\n', 'key\n', 'significant\n', 'material\n', 'compensating\n', '0', '11', 'LO2'),
(431, 'Before making the final assessment of internal control at the end of an audit, the auditor must\n', '\nTest controls 	Perform substantive tests \nYes	Yes\n\n', '\nTest controls 	Perform substantive tests \nNo	No\n\n', '\nTest controls 	Perform substantive tests \nYes	No\n\n', '\nTest controls 	Perform substantive tests\nNo	Yes\n\n', '0', '11', 'LO2'),
(432, 'When identifying audit objectives and existing controls,\n', 'audit objectives are identified for classes of transactions, account balances, and presentation and disclosure.\n', 'the auditor identifies controls to satisfy each objective.\n', 'it is helpful for the auditor to use the five control activities as reminders of controls.\n', 'all of the above\n', '3', '11', 'LO2'),
(433, 'A(n) ________ control is a control elsewhere in the system that offsets the absence of a key control.\n', 'significant\n', 'alternate\n', 'design\n', 'compensating\n', '3', '11', 'LO2'),
(434, 'A ________ exists if one or more control deficiencies exist that are less severe than a material weakness, but are important enough to merit attention by those responsible for oversight of the company\'s financial reporting.\n', 'potential misstatement\n', 'significant weakness\n', 'significant deficiency\n', 'fraud symptom\n', '2', '11', 'LO2'),
(435, 'A five-step approach can be used to identify deficiencies, significant deficiencies, and material weaknesses. The first step in this approach is\n', 'identify the absence of key controls.\n', 'consider the possibility of compensating controls.\n', 'determine potential misstatements that could result.\n', ' identify existing controls.\n', '3', '11', 'LO2'),
(436, 'When assessing control risk,\n', 'many auditors use actuarial tables to assist in the control risk assessment process.\n', 'each control can be used to satisfy only one audit objective.\n', 'many auditors use a control risk matrix to assist in the control risk assessment process.\n', 'all controls, including key controls, should be considered.\n', '2', '11', 'LO2'),
(437, 'When a compensating control exists, the absence of a key control\n', 'is no longer a concern because there is no longer a significant deficiency or material weakness.\n', 'is still a major concern to the auditor.\n', 'could cause a material loss, so it must be tested using substantive procedures.\n', 'is magnified and must be removed from the sampling process and examined in its entirety.\n', '0', '11', 'LO2'),
(438, 'The assessment of control risk is the measure of the auditor\'s expectation that internal controls will prevent material misstatements from occurring or detect and correct them if they have occurred.\n', '', '', '', '', 'T', '11', 'LO2'),
(439, 'Key controls are not sufficient to achieve the transaction-related audit objectives.\n', '', '', '', '', 'F', '11', 'LO2'),
(440, 'A design deficiency exists if the person performing the control is not qualified.\n', '', '', '', '', 'F', '11', 'LO2'),
(441, 'A significant internal control deficiency is always considered a material weakness.\n', '', '', '', '', 'F', '11', 'LO2'),
(442, 'In some cases, management can correct deficiencies and material weaknesses before the auditor does significant testing, which may permit a reduction in control risk.\n', '', '', '', '', 'T', '11', 'LO2'),
(443, 'If the results of tests of controls support the design and operations of controls as expected, the auditor uses ________ control risk as the preliminary assessment. \n', 'a lower\n', 'the same\n', 'a higher\n', 'either a lower or higher \n', '1', '11', 'LO3'),
(444, 'An auditor is likely to use four types of procedures to support the operating effectiveness of internal controls. Which of the following would generally not be used?\n', 'make inquiries of appropriate client personnel\n', 'examine documents, records, and reports\n', 'reperform client procedures\n', 'inspect design documents\n', '3', '11', 'LO3'),
(445, 'Which of the following represents a correct statement regarding internal control testing?\n', 'When auditors plan to use evidence about the operating effectiveness of internal control contained in prior audits, auditing standards require tests of the controls\' effectiveness at least every other year.\n', 'The greater the risk, the less audit evidence the auditor should obtain that controls are operating effectively.\n', 'The auditor uses control risk assessment and results of tests of controls to determine planned detection risk and the related substantive tests for the financial statement audit.\n', 'Testing of internal controls can only be performed by the auditor at the end of the fiscal year.\n', '2', '11', 'LO3'),
(446, 'An auditor traces the sales prices to the authorized price list in effect at the date of the transaction. Which of the following procedures has the auditor performed?\n', 'inquiry\n', 'observation\n', 'reperformance\n', 'examination\n', '2', '11', 'LO3'),
(447, 'Tests of controls\n', 'are the procedures used to test the effectiveness of controls in support of a reduced assessed control risk.\n', 'are used to support the ending balances in the balance sheet and income statement accounts.\n', 'are performed at the end of the audit.\n', 'are designed to detect fraud.\n', '0', '11', 'LO3'),
(448, 'Which of the following is an accurate statement relating to the extent of procedures?\n', 'If an auditor wants a lower assessed control risk than the preliminary assessed control risk, the number of controls tested increases while the extent of the tests for each control decrease.\n', 'The extent of testing depends on the frequency of the operation of the controls.\n', 'All controls must be tested only at year-end.\n', 'The frequency of testing is the same for both manual and computer controls.\n', '1', '11', 'LO3'),
(449, 'When testing manual or automated controls,\n', 'automated controls are always subject to random error or manipulation.\n', 'automated controls cannot be altered by making a change to the software application.\n', 'when there are effective general controls and automated application controls, the auditor will need to select a larger sample size of transactions to verify.\n', 'the extent of testing depends on whether it is a manual or automated control.\n', '3', '11', 'LO3'),
(450, 'Which of the following is true regarding the relationship between tests of controls and procedures to obtain an understanding?\n', 'In obtaining an understanding of internal control, the procedures to obtain an understanding are applied to all controls identified during that phase.\n', 'Tests of controls are applied only when the assessed control risk has not been satisfied by the procedures to obtain an understanding.\n', 'Procedures to obtain an understanding are performed only on one or a few transactions.\n', 'All of the above are correct.\n', '3', '11', 'LO3'),
(451, 'When a client uses a service center for processing transactions,\n', 'the auditor can assume that the controls are adequate because it is an independent enterprise.\n', 'auditing standards require the auditor to test the service center\'s controls if the service center application involves processing significant financial data.\n', 'and the user auditor decides to rely on the service auditor\'s report, the user audit must make reference to the report of the service auditor in the opinion on the user organization\'s financial statements.\n', 'none of the above\n', '1', '11', 'LO3'),
(452, 'The procedures to obtain an understanding of internal control are only applied when the assessed control risk is high.\n', '', '', '', '', 'F', '11', 'LO3'),
(453, 'Controls that are applied throughout the accounting period must be tested both at an interim date and then again on the balance sheet date.\n', '', '', '', '', 'F', '11', 'LO3'),
(454, 'When there are a number of controls tested in prior audits that have not been changed, auditing standard require auditors to test some of those controls each year to ensure there is a rotation of controls testing throughout the three-year period.\n', '', '', '', '', 'T', '11', 'LO3'),
(455, 'Which of the following is a correct statement?\n', 'The auditor uses the control risk assessment and results of tests of controls to determine planned detection risk.\n', 'The auditor links the inherent risk assessments to the balance-related audit objectives.\n', 'The audit risk model is used determine the level of audit risk.\n', 'All of the above are correct statements.\n', '0', '11', 'LO4'),
(456, 'The auditor assesses control risk for each related audit objective and supports control risk assessments with tests of controls.\n', '', '', '', '', 'T', '11', 'LO4'),
(457, 'How must significant deficiencies and material weaknesses be communicated to those charged with governance?\n', 'Either oral or written communication is acceptable.\n', 'Oral communication is required.\n', 'Written communication is required.\n', 'Written communication is required for material weaknesses, but oral communication is allowed for significant deficiencies.\n', '2', '11', 'LO5'),
(458, 'Auditors often identify less significant internal control-related issues, as well as opportunities for the client to make operational improvements in the \n', 'adverse opinion.\n', 'Section 404 report.\n', 'management letter.\n', 'Type 1 report.\n', '2', '11', 'LO5'),
(459, 'The auditor will issue an unqualified opinion on internal control over financial reporting when\n', 'there are no identified material weaknesses as of the end of the fiscal year.\n', 'there have been no restrictions on the scope of the auditor\'s work.\n', 'both a and b\n', 'either a or b\n', '2', '11', 'LO5'),
(460, 'What type of report is issued when one or more material internal control weaknesses exist?\n', 'unqualified opinion\n', 'disclaimer of opinion\n', 'adverse opinion\n', 'qualified opinion\n', '2', '11', 'LO5'),
(461, 'Which of the following is true regarding the auditor\'s opinion on the effectiveness of internal control?\n', 'The auditor is attesting to the effectiveness of internal controls as of the end of the fiscal year.\n', 'If the client remedies a material weakness before the end of the fiscal year, the auditor must still issue a qualified opinion or a disclaimer of opinion.\n', 'A scope limitation requires the auditor to issues an adverse opinion.\n', 'Section 404 requires that the auditor design the audit to detect all deficiencies in internal control.\n', '0', '11', 'LO5'),
(462, 'When determining what type of report to issue on internal control under Section 404,\n', 'an adverse opinion on internal control must be given if any weaknesses in a key internal control is discovered.\n', 'a scope limitation requires the auditor to disclaim an opinion on internal controls.\n', 'if the auditor gives a qualified opinion on the financial statements, they must give a qualified opinion on internal controls.\n', 'a scope limitation requires the auditor to express a qualified opinion or a disclaimer of opinion on internal controls.\n', '3', '11', 'LO5'),
(463, 'The scope of the auditor\'s report on internal control is limited to obtaining reasonable assurance that significant weaknesses in internal control are identified.\n', '', '', '', '', 'F', '11', 'LO5'),
(464, 'To issue an unqualified opinion on internal control over financial reporting, there must be no identified material weaknesses and no restrictions on the scope of the audit.\n', '', '', '', '', 'T', '11', 'LO5'),
(465, 'It is generally possible for small companies to have all of the following except for\n', 'adequate documents and records.\n', 'physical controls over assets.\n', 'competent, trustworthy personnel.\n', 'internal auditors.\n', '3', '11', 'LO6'),
(466, 'The auditor designs and performs a combination of tests of controls and substantive procedures to obtain reasonable assurance that the financial statements are fairly stated when control risk \n', 'is assessed above the maximum.\n', 'is assessed below the maximum.\n', 'cannot be assessed.\n', 'none of the above\n', '1', '11', 'LO6'),
(467, 'In the audit of a private company, the auditor will test internal controls when control risk is initially assessed at\n', '\nLow	Moderate	High\nYes	No	Yes\n\n', '\nLow	Moderate	High\nNo	No	Yes\n\n', '\nLow	Moderate	High\nYes	Yes	No\n\n', '\nLow	Moderate	High\nNo	Yes	No\n\n', '2', '11', 'LO6'),
(468, 'Which of the following may represent the biggest challenge smaller public companies and nonpublic companies face in implementing effective internal control?\n', 'a lack of competent, trustworthy personnel\n', 'no clear lines of authority\n', 'no adequate separation of duties\n', 'a lack of adequate documents and records\n', '2', '11', 'LO6'),
(469, 'Which of the following is most correct for audits of non-public companies?\n', 'An audit of internal control is required.\n', 'An audit of internal control is not required.\n', 'An audit of the design of internal controls is required.\n', 'An audit of the operational effectiveness of internal controls is required.\n', '1', '11', 'LO6'),
(470, 'If, when obtaining an understanding of control activities of a relatively small client, the auditor identified no control activities, the auditor would probably set a high assessment of control risk.\n', '', '', '', '', 'T', '11', 'LO6'),
(471, 'The auditor obtains a sufficient understanding of internal control to assess the risk of material misstatement at the overall financial statement level and at the relevant assertion level.\n', '', '', '', '', 'T', '11', 'LO6'),
(472, 'The procedures used to gain an understanding of internal control do not vary from client to client.\n', '', '', '', '', 'F', '11', 'LO6'),
(473, 'In an audit of a nonpublic company, the less control risk there is, the smaller the amount of planned substantive evidence that is required.\n', '', '', '', '', 'T', '11', 'LO6'),
(474, 'The assessment of control risk does not impact the testing of controls.\n', '', '', '', '', 'F', '11', 'LO6'),
(475, 'A company\'s size should have no impact on the nature of internal control and the controls that are implemented.\n', '', '', '', '', 'F', '11', 'LO6'),
(476, 'Control risk is generally set at minimum for most private companies.\n', '', '', '', '', 'F', '11', 'LO6'),
(477, 'The auditor\'s objective in determining whether the client\'s computer program correctly processes valid and invalid transactions is accomplished through the\n', 'test data approach.\n', 'generalized audit software approach.\n', 'microcomputer-aided auditing approach.\n', 'generally accepted auditing standards.\n', '0', '11', 'LO7'),
(478, 'When using the test data approach,\n', 'auditors process test data supplied by the client.\n', 'auditors often obtain assistance from a computer audit specialist.\n', 'the tests must be performed at the end of the year.\n', 'the test data must remain in the client\'s records.\n', '1', '11', 'LO7'),
(479, 'Which of the following is not seen as an advantage to using generalized audit software (GAS)?\n', 'Auditors can learn the software in a short period of time.\n', 'It can be applied to a variety of clients after detailed customization. \n', 'It can be applied to a variety of clients with minimal adjustments to the software.\n', 'It greatly accelerates audit testing over manual procedures.\n', '1', '11', 'LO7'),
(480, 'When using the test data approach,\n', 'test data should include data that the client\'s system should accept or reject.\n', 'application programs tested by the auditor\'s test data must be different from those used by the client throughout the year.\n', 'select data may remain in the client system after testing.\n', 'None of the above statements is correct. \n', '0', '11', 'LO7'),
(481, 'Auditing by testing automated internal controls and account balances electronically, generally because effective general controls exist, is known as\n', 'auditing through the computer.\n', 'auditing around the computer.\n', 'embedded audit module approach.\n', 'parallel simulation testing.\n', '0', '11', 'LO7'),
(482, 'Which of the following computer-assisted auditing techniques inserts an audit module in the client\'s application system to identify specific types of transactions?\n', 'parallel simulation testing\n', 'test data approach\n', 'embedded audit module\n', 'generalized audit software testing \n', '2', '11', 'LO7'),
(483, 'Which of the following best describes the test data approach?\n', 'Auditors process their own test data using the client\'s computer system and application program.\n', 'Auditors process their own test data using their own computers that simulate the client\'s computer system.\n', 'Auditors use auditor-controlled software to do the same operations that the client\'s software does, using the same data files.\n', 'Auditors use client-controlled software to do the same operations that the client\'s software does, using auditor created data files.\n', '0', '11', 'LO7'),
(484, 'The embedded audit module approach requires the auditor to insert an audit module in the client\'s application system to to identify specific types of transactions.\n', '', '', '', '', 'T', '11', 'LO7'),
(485, 'The objective of the test data approach is to determine whether the client\'s computer programs can correctly process valid and invalid transactions.\n', '', '', '', '', 'T', '11', 'LO7'),
(486, 'Parallel simulation is used primarily to test internal controls over the client\'s IT systems, whereas the test data approach is used primarily for substantive testing.\n', '', '', '', '', 'F', '11', 'LO7'),
(487, 'Generalized audit software is used to test automated controls.\n', '', '', '', '', 'T', '11', 'LO7'),
(488, 'Shown below (1 through 5) are the five types of tests which auditors use to determine whether financial statements are fairly stated. Which three are substantive tests?\n1.	risk assessment procedures\n2.	tests of controls\n3.	substantive tests of transactions\n4.	substantive analytical procedures\n5. 	tests of details of balances\n', '1, 2, and 3\n', '3, 4, and 5\n', '2, 3, and 5\n', '2, 3, and 4\n', '1', '12', 'LO1'),
(489, 'Collectively, procedures performed to obtain an understanding of the entity and its environment, including internal controls, represent the auditor\'s\n', 'audit strategy.\n', 'tests of controls.\n', 'risk assessment procedures.\n', 'tests of transactions.\n', '2', '12', 'LO1'),
(490, 'Which of the following would not be considered further audit procedures?\n', 'tests of controls\n', 'analytical procedures\n', 'tests of details of balances\n', 'risk assessment procedures\n', '3', '12', 'LO1'),
(491, 'Which of the following procedures would most likely be performed in response to the auditor\'s assessment of the risk of monetary misstatements in the financial statements?\n', 'ratio analysis\n', 'tests of controls\n', 'tests of details of balances\n', 'risk assessment procedures\n', '2', '12', 'LO1'),
(492, 'Which of the following further audit procedures are used to determine whether all six transaction-related audit objectives have been achieved for each class of transactions?\n', 'tests of controls\n', 'risk assessment procedures\n', 'substantive tests of transactions\n', 'preliminary analytical procedures\n', '2', '12', 'LO1'),
(493, 'You are auditing Rodgers and Company. After performing substantive analytical procedures you conclude that, for the accounts tested, the client\'s balance appears reasonable. This may indicate that\n', 'details test of balances can be eliminated for those accounts.\n', 'certain tests of details of balances may be eliminated for those accounts.\n', 'control tests may be eliminated for those accounts.\n', 'control tests may be reduced for those accounts.\n', '1', '12', 'LO1'),
(494, 'The purpose of tests of controls is to provide reasonable assurance that the\n', 'accounting treatment of transactions and balances is valid and proper.\n', 'internal control procedures are functioning as intended.\n', 'entity has complied with GAAP disclosure requirements.\n', 'entity has complied with requirements of quality control.\n', '1', '12', 'LO1'),
(495, 'In the context of an audit of financial statements, substantive tests are audit procedures that\n', 'may be eliminated under certain conditions.\n', 'are designed to discover significant subsequent events.\n', 'are designed to test for dollar misstatements.\n', 'will increase proportionately with the auditor\'s reliance on internal control.\n', '2', '12', 'LO1');
INSERT INTO `question_table` (`id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `answer`, `chapter`, `LO`) VALUES
(496, 'Which of the following is true? \n', 'Tests of details of balances focus on the ending general ledger balances for both balance sheet and income statement accounts.\n', 'Tests of details of balances focus on the transactions during the period for both balance sheet and income statement accounts.\n', 'Tests of details of balances focus on the auditor\'s understanding of internal controls.\n', 'Tests of details of balances focus on comparisons of recorded amounts to expectations developed by the auditor.\n', '0', '12', 'LO1'),
(497, 'A system walkthrough is primarily used to help the auditor\n', 'test the ending account balances.\n', 'test the details of transactions.\n', 'determine whether internal controls have been properly implemented.\n', 'determine whether the audit engagement should be accepted.\n', '2', '12', 'LO1'),
(498, 'Risk assessment procedures are performed by auditors during an audit in order to\n', 'determine the risk of material misstatement in the financial statements.\n', 'determine the amount of testing of internal control.\n', 'determine the extent of testing of details of balances.\n', 'determine the extent of testing of transactions.\n', '0', '12', 'LO1'),
(499, 'Tests of controls are directed toward the control\'s\n', 'efficiency.\n', 'effectiveness.\n', 'cost and effectiveness.\n', 'cost benefit ratio.\n', '1', '12', 'LO1'),
(500, 'A procedure designed to test for monetary misstatements directly affecting the correctness of financial statement balances is a\n', 'test of controls.\n', 'substantive test.\n', 'test of attributes.\n', 'monetary unit sampling test.\n', '1', '12', 'LO1'),
(501, 'Analytical procedures\n', 'focus on the ending balances for income statement accounts.\n', 'are only performed during the planning stage of the audit.\n', 'are required to be performed when auditing an account balance.\n', 'provide substantive evidence.\n', '3', '12', 'LO1'),
(502, 'The primary emphasis in most tests of details of balances is on the\n', 'balance sheet accounts.\n', 'revenue accounts.\n', 'cash flow statement accounts.\n', 'expense accounts.\n', '0', '12', 'LO1'),
(503, 'Which of the following statements is not true?\n', 'Analytical procedures emphasize the overall reasonableness of transactions and balances.\n', 'Tests of controls are concerned with evaluating whether controls are sufficiently effective to justify reducing control risk and thereby reducing analytical review procedures.\n', 'Substantive tests of transactions emphasize the verification of transactions recorded in the journals and then posted in the general ledger.\n', 'Tests of details of balances emphasize the ending balances in the general ledger.\n', '1', '12', 'LO1'),
(504, 'Many auditors perform extensive analytical procedures because\n', 'they are required by GAAS.\n', 'they pinpoint errors in accounts.\n', 'they indicate areas of potential risk and misstatement.\n', 'they are required for tests of controls.\n', '2', '12', 'LO1'),
(505, 'The auditor has determined that a key control in the audit of the sales and collection cycle is that recorded sales are supported by authorized shipping documents and approved customer orders. What typical test of controls should be used in this situation?\n', 'Examine a sample of duplicate sales invoices to determine that each on is supported by an authorized shipping document and approved customer order.\n', 'Observe whether shipping documents are forwarded daily to billing and observe when they are billed.\n', 'Examine a sample of sales invoices and agree prices to the authorized computer price list.\n', 'Use audit software to trace postings from the batch of sales transactions to the subsidiary and general ledgers.\n', '0', '12', 'LO1'),
(506, 'Which of the following is ordinarily designed to detect material dollar errors on the financial statements?\n', 'tests of controls\n', 'analytical review procedures\n', 'computer controls\n', 'tests of details of balances\n', '3', '12', 'LO1'),
(507, 'For automated controls, the auditor\'s procedures to determine whether the automated control has been implemented cannot also serve as the test of that control.\n', '', '', '', '', 'F', '12', 'LO1'),
(508, 'Procedures to obtain an understanding of internal control generally provide sufficient appropriate evidence that a control is operating effectively.\n', '', '', '', '', 'F', '12', 'LO1'),
(509, 'Substantive tests are procedures designed to test for dollar misstatements that directly affect the correctness of financial statement balances.\n', '', '', '', '', 'T', '12', 'LO1'),
(510, 'Risk assessment procedures are performed to assess the risk of material misstatement in the financial statements.\n', '', '', '', '', 'T', '12', 'LO1'),
(511, 'Tests of controls should be performed after substantive tests of transactions.\n', '', '', '', '', 'F', '12', 'LO1'),
(512, 'Tests of details of balances emphasize the overall reasonableness of transactions and the general ledger balances.\n', '', '', '', '', 'F', '12', 'LO1'),
(513, 'Auditors must perform tests of controls separately from substantive tests of transactions.\n', '', '', '', '', 'F', '12', 'LO1'),
(514, 'One factor that determines the amount of additional evidence required for tests of controls is the planned reduction in control risk.\n', '', '', '', '', 'T', '12', 'LO1'),
(515, 'Tests of controls are performed to support a reduced assessment of detection risk.\n', '', '', '', '', 'F', '12', 'LO1'),
(516, 'In order to promote audit efficiency the auditor considers cost in selecting audit tests to perform. Which of the following audit tests would be the most costly?\n', 'substantive analytical procedures\n', 'risk assessment procedures\n', 'tests of controls\n', 'tests of details of balances\n', '3', '12', 'LO2'),
(517, 'An exception or deficiency found in a test of controls\n', 'indicates a financial statement misstatement.\n', 'indicates the likelihood of a misstatement.\n', 'indicates that the financial statements are fairly stated.\n', 'indicates that an adverse opinion is warranted on the audit of internal control.\n', '1', '12', 'LO2'),
(518, 'If no material differences are found using analytical procedures, and the auditor concludes that misstatements are not likely to have occurred,\n', 'other substantive tests may be reduced.\n', 'it will be necessary to increase the tests of balances.\n', 'it will not be necessary to perform tests of balances.\n', 'it will be necessary to increase the tests of transactions.\n', '0', '12', 'LO2'),
(519, 'Which of the following audit tests is usually the least costly to perform?\n', 'substantive analytical procedures\n', 'tests of controls\n', 'tests of balances\n', 'substantive tests of transactions\n', '0', '12', 'LO2'),
(520, 'An increased extent of tests of controls is most likely to occur when\n', 'it is a first-year audit.\n', 'the auditor is doing a \"fraud audit.\"\n', 'controls are effective and the preliminary control risk assessment is low.\n', 'controls are ineffective and the preliminary control risk assessment is high.\n', '2', '12', 'LO2'),
(521, 'When an auditor believes that analytical procedures indicate a reasonable possibility of misstatement, the auditor usually would\n', '\nPerform additional tests of controls 	Decide to modify tests of details of balances\nYes	Yes\n\n', '\nPerform additional tests of controls 	Decide to modify tests of details of balances\nNo	No\n\n', '\nPerform additional tests of controls 	Decide to modify tests of details of balances\nYes	No\n\n', '\nPerform additional tests of controls 	Decide to modify tests of details of balances\nNo	Yes\n\n', '3', '12', 'LO2'),
(522, 'If tests of controls support the control risk assessment, then ________ in the audit risk model is increased.\n', 'planned detection risk\n', 'planned inherent risk\n', 'planned fraud risk\n', 'planned assurance risk\n', '0', '12', 'LO2'),
(523, 'The auditor would design which of the following audit tests to detect possible monetary errors in the financial statements?\n', 'control tests\n', 'substantive analytical procedures\n', 'risk assessment procedures\n', 'tests of operating effectiveness of controls over revenue and cash\n', '1', '12', 'LO2'),
(524, 'The reliance the auditor places on substantive tests in relation to the reliance placed on internal control varies in a relationship that is ordinarily\n', 'parallel.\n', 'inverse.\n', 'direct.\n', 'equal.\n', '1', '12', 'LO2'),
(525, ' A deficiency uncovered in the audit of internal control is explained by which of the following in relation to a financial statement misstatement?\n', 'the amount of the misstatement\n', 'the likelihood of the misstatement\n', 'the amount, likelihood, and classification of the misstatement\n', 'the amount and the classification of the misstatement\n', '1', '12', 'LO2'),
(526, 'Several factors influence the auditor\'s choice of the types of tests to select, including\n', 'the availability of the types of evidence.\n', 'the relative costs of each type of test.\n', 'the effectiveness of the internal controls.\n', 'all of the above.\n', '3', '12', 'LO2'),
(527, 'Tests of controls are generally more costly to perform than analytical procedures.\n', '', '', '', '', 'T', '12', 'LO2'),
(528, 'Only tests of details of balances involve physical examination and confirmation.\n', '', '', '', '', 'T', '12', 'LO2'),
(529, 'Analytical procedures are the least costly type of audit test.\n', '', '', '', '', 'T', '12', 'LO2'),
(530, 'In a computerized environment, the auditor can often perform substantive tests of transactions quickly for a large sample of transactions.\n', '', '', '', '', 'T', '12', 'LO2'),
(531, 'The cost of each type of evidence does not vary in different situations.\n', '', '', '', '', 'F', '12', 'LO2'),
(532, 'Because of the high cost of tests of details of balances, auditors do not perform this type of testing unless fraud is suspected. \n', '', '', '', '', 'F', '12', 'LO2'),
(533, 'The auditor\'s understanding of internal control performed as part of risk assessment procedures provides the basis for the auditor\'s initial assessment of control risk.\n', '', '', '', '', 'T', '12', 'LO2'),
(534, 'Analytical procedures are the most expensive type of audit test to perform because of the expertise and training required to properly use them.\n', '', '', '', '', 'F', '12', 'LO2'),
(535, 'The results of tests of controls and substantive tests of transactions affect the design of tests of details of balances.\n', '', '', '', '', 'T', '12', 'LO2'),
(536, 'If internal controls are tested and are considered effective, the auditor generally will increase both substantive tests of transactions and tests of details of balances.\n', '', '', '', '', 'F', '12', 'LO2'),
(537, 'Tests of controls provide evidence about the likelihood for misstatements in a client\'s financial statements.\n', '', '', '', '', 'T', '12', 'LO2'),
(538, 'An exception in a test of control provides only an indication of the likelihood of monetary misstatements in the financial statements because tests of controls do not reveal whether monetary misstatements have actually occurred.\n', '', '', '', '', 'T', '12', 'LO2'),
(539, 'Which of the following is generally not included in the \"evidence mix\"?\n', 'tests of controls\n', 'substantive tests of transactions\n', 'risk assessment procedures\n', 'tests of details of balances\n', '2', '12', 'LO3'),
(540, 'The ________ is the combination of the types of tests to obtain sufficient appropriate evidence for a cycle. There are likely to be variations in the mix from cycle to cycle depending on the circumstances of the audit.\n', 'testing mix\n', 'evidence mix\n', 'audit process mix\n', 'procedures mix\n', '1', '12', 'LO3'),
(541, 'Which of the following would most likely not be included in the evidence mix for an integrated audit of a public company\'s financial statements and internal control over financial reporting?\n', 'sophisticated internal controls\n', 'extensive substantive analytical procedures\n', 'extensive tests of details of balances\n', 'low inherent risk\n', '2', '12', 'LO3'),
(542, 'If the auditor finds extensive control test deviations and significant misstatements while performing substantive tests of transactions and substantive analytical procedures,\n', 'the cost of the audit should decrease.\n', 'the auditor will conclude that internal controls are effective.\n', 'extensive tests of details of balances will need to be performed.\n', 'all of the above\n', '2', '12', 'LO3'),
(543, 'The evidence mix includes risk assessment procedures.\n', '', '', '', '', 'F', '12', 'LO3'),
(544, 'The choice of which types of tests to use and how extensively they need to be performed must be the same for all audits.\n', '', '', '', '', 'F', '12', 'LO3'),
(545, 'The document that details the specific audit procedures for each type of test is the\n', 'audit strategy.\n', 'audit program.\n', 'audit procedure.\n', 'audit risk model.\n', '1', '12', 'LO4'),
(546, 'Auditors follow a four step approach to reduce assessed control risk. Which of the following is not one of the four?\n', 'Apply transaction-related audit objectives to a class of transactions.\n', 'Identify accounts that have high inherent risk.\n', 'Identify key controls that reduce control risk.\n', 'For potential misstatements, design appropriate substantive tests of transactions.\n', '1', '12', 'LO4'),
(547, 'When designing the audit program and the particular audit tests, the auditor should keep in mind that\n', 'the audit program is broken down into two parts-the risk assessment procedures and the tests of details of balances.\n', 'the tests of controls will not vary depending on assessed control risk.\n', 'analytical procedures performed during substantive testing are generally more focused and more extensive than those done as part of planning.\n', 'auditing standards require that the tests contained in the audit program must be approved by the PCAOB.\n', '2', '12', 'LO4'),
(548, 'The auditor obtained an aged list of receivables and traced the accounts to the master file, footed the schedule, and traced the amounts to the general ledger. Which balance-related audit objective was met?\n', 'existence\n', 'cutoff\n', 'detail tie-in\n', 'all of the above\n', '2', '12', 'LO4'),
(549, 'One of the most challenging parts of auditing is properly applying the factors that affect tests of details of balances.\n', '', '', '', '', 'T', '12', 'LO4'),
(550, 'Auditing standards require a written audit program.\n', '', '', '', '', 'T', '12', 'LO4'),
(551, 'When designing an audit program for tests of details of balances, the auditor should make assumptions about inherent risk and control risk, and predictions concerning the outcome of tests of controls, substantive tests of transactions, and analytical procedures.\n', '', '', '', '', 'T', '12', 'LO4'),
(552, 'Once set during the planning phase, the audit program cannot be revised.\n', '', '', '', '', 'F', '12', 'LO4'),
(553, 'Inherent risk can be extended to individual balance-related audit objectives.\n', '', '', '', '', 'T', '12', 'LO4'),
(554, 'When controls are effective and control risk is assessed as low, auditors put heavy emphasis on tests of balances.\n', '', '', '', '', 'F', '12', 'LO4'),
(555, 'There is a direct relationship between the ________ transaction-related audit objective and the ________ balance-related audit objective.\n', 'occurrence; existence\n', 'timing; cutoff\n', 'posting and summarization; detail tie-in\n', 'all of the above\n', '3', '12', 'LO5'),
(556, 'If all transaction-related audit objectives are met, the auditor does not need to perform substantive test of balances to meet the realizable value audit objective.\n', '', '', '', '', 'F', '12', 'LO5'),
(557, 'The auditor performs tests of controls and substantive procedures to obtain assurance that all audit objectives are achieved for information and amounts included in those disclosures.\n', '', '', '', '', 'T', '12', 'LO5'),
(558, 'What type of test is used to obtain the most types of evidence?\n', 'substantive tests of transactions\n', 'tests of controls\n', 'risk assessment tests\n', 'tests of details of balances\n', '3', '12', 'LO6'),
(559, 'Which phase(s) of the audit uses inquiries of clients as a type of evidence?\n', 'plan and design \n', 'tests of controls and substantive tests of transactions \n', 'completion of the audit and issuance of the audit report\n', 'all of the above\n', '3', '12', 'LO6'),
(560, 'Which audit tests involve physical examination and confirmation?\n', 'tests of controls\n', 'tests of transactions\n', 'tests of details of balances\n', 'analytical procedures\n', '2', '12', 'LO6'),
(561, 'Which of the following types of evidence is not available when using substantive tests of transactions?\n', 'inspection\n', 'confirmation\n', 'inquiries of the client\n', 'reperformance\n', '1', '12', 'LO6'),
(562, 'Presentation and disclosure objectives are primarily addressed in the tests of details of balances phase of the audit.\n', '', '', '', '', 'F', '12', 'LO6'),
(563, 'Presentation and disclosure related audit objectives would be performed in which phase of the audit process?\n', 'plan and design audit approach\n', 'perform audit tests for controls and transactions\n', 'perform analytical procedures and tests of balances\n', 'complete the audit and issue the audit report\n', '3', '12', 'LO7'),
(564, 'Transaction-related audit objectives would most likely be performed in which phase of the audit process?\n', 'plan and design audit approach\n', 'perform tests of controls and substantive tests of transactions\n', 'perform substantive analytical procedures and tests of details of balances\n', 'complete the audit and issue the audit report\n', '1', '12', 'LO7'),
(565, 'Which of the following is an accurate statement regarding the four phases of the audit process?\n', 'After the planning stage, the auditor should have a well-defined audit strategy and plan and a specific audit program for the entire audit.\n', 'The objective of phase III is to perform tests of controls.\n', 'During phase II, the auditor must evaluate the going-concern assumption.\n', 'All of the above are correct statements.\n', '0', '12', 'LO7'),
(566, 'Which of the following tests commonly occur together?\n', 'substantive tests of transactions and tests of controls\n', 'substantive tests of transactions and obtaining an understanding of internal controls\n', 'analytical procedures and tests of controls\n', 'tests of controls and tests of details of balances\n', '0', '12', 'LO7'),
(567, 'Tests of controls and substantive tests of transactions are an important determinant of the extent of the auditor\'s use of tests of details of balances. Which of the following is true?\n', 'They are likely to be performed prior to the client\'s end of the fiscal year.\n', 'They are likely to eliminate the need for tests of details of balances.\n', 'They are likely to have no impact on the planned tests of details of balances.\n', 'They are likely to be used only in the audit of internal control.\n', '0', '12', 'LO7'),
(568, 'When the auditor has completed the tests of details of balances and enters phase IV of the audit process, she must still perform audit procedures for which of the following?\n', 'contingent liabilities and employee compensation\n', 'contingent liabilities and subsequent events\n', 'subsequent events and contractual commitments\n', 'subsequent events and unrecorded liabilities\n', '1', '12', 'LO7'),
(569, 'Which of the following audit tests would be regarded as a test of controls?\n', 'comparison of the inventory pricing to vendors\' invoices\n', 'tests of the signatures on canceled checks to board of directors\' authorizations\n', 'tests of the additions to property, plant, and equipment by physical inspections\n', 'review of the specific items making up the balance in a given general ledger account\n', '1', '12', 'LO7'),
(570, 'Which of the following audit tests form the basis for an auditor\'s report on internal control over financial reporting?\n', 'analytical procedures\n', 'tests of transactions\n', 'tests of controls\n', 'tests of details of balances\n', '2', '12', 'LO7'),
(571, 'Management implements internal controls to ensure that all required footnote disclosures are accurate. Auditors tests those controls to provide evidence supporting the ________ presentation.\n', 'completeness and valuation\n', 'completeness and accuracy\n', 'rights and obligations and existence\n', 'occurrence and accuracy\n', '1', '12', 'LO7'),
(572, 'At what point in the audit process are tests of details most appropriately designed?\n', 'plan and design audit approach\n', 'perform audit tests of controls and substantive tests of transactions\n', 'perform substantive analytical procedures and tests of details of balances\n', 'complete the audit and issue the audit report\n', '2', '12', 'LO7'),
(573, 'Which of the following is not completed during phase IV of the audit?\n', 'Obtain a client representation letter.\n', 'Read information in the annual report to make sure that it is consistent with the financial statements.\n', 'Perform substantive tests of transactions.\n', 'Perform final analytical procedures.\n', '2', '12', 'LO7'),
(574, 'For clients with highly sophisticated computerized accounting systems, auditors perform tests throughout the year to identify significant or unusual transactions. This approach is called ________ and is frequently used in integrated audits of financial statements and internal control for public companies.\n', 'continuous audit program\n', 'continuous auditing\n', 'continuous analytical testing\n', 'continuous audit mix\n', '1', '12', 'LO7'),
(575, 'Analytical procedures performed during phase III of the audit\n', 'must be performed before the balance sheet date.\n', 'can be used as a means of planning and directing other audit tests to specific areas.\n', 'should be done after tests of details of balances.\n', 'are expensive and are therefore not frequently used by the auditor.\n', '1', '12', 'LO7'),
(576, 'The auditor must communicate significant deficiencies in internal control only after the entire audit is complete to ensure the auditor has a sufficient understanding of the circumstances surrounding the deficiency.\n', '', '', '', '', 'F', '12', 'LO7'),
(577, 'Subsequent events represent events that occasionally occur after the balance sheet date, but before the issuance of the financial statements and the auditor\'s report, that have an effect on the financial statements.\n', '', '', '', '', 'T', '12', 'LO7'),
(578, 'Substantive tests of balances performed before year-end provide significant assurance and are normally only done when internal controls are ineffective.\n', '', '', '', '', 'F', '12', 'LO7');

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `student_ID` text NOT NULL,
  `pwd` text NOT NULL,
  `email` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `role_id` int(11) NOT NULL,
  `auth_code` text DEFAULT NULL,
  `var_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_general_ci COMMENT='student_info';

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`ID`, `student_ID`, `pwd`, `email`, `is_active`, `role_id`, `auth_code`, `var_code`) VALUES
(2, 'h14086030', '$2y$10$qLYqXDFcxYilIgq4PxyIHOueHLsxDHyQTHe8befT16MMUidCuNism', 'h14086030@gs.ncku.edu.tw', 1, 0, 'b76466ae9f749b59f5ecbec11a8bf31a0fd8ab9409aad33a93dec0b763f75c1b', 0),
(3, 'h00000000', '$2y$10$qLYqXDFcxYilIgq4PxyIHOueHLsxDHyQTHe8befT16MMUidCuNism', 'h14086030@gs.ncku.edu.tw', 1, 0, 'a9633e3507df101d295ccf7b9d1883a891f70602467f24e64e42e6a0024bcb7e', 0),
(4, 'h00000002', '$2y$10$qLYqXDFcxYilIgq4PxyIHOueHLsxDHyQTHe8befT16MMUidCuNism', 'h14086030@gs.ncku.edu.tw', 1, 0, 'a9633e3507df101d295ccf7b9d1883a891f70602467f24e64e42e6a0024bcb7e', 0),
(5, 'h00000004', '$2y$10$qLYqXDFcxYilIgq4PxyIHOueHLsxDHyQTHe8befT16MMUidCuNism', 'h14086030@gs.ncku.edu.tw', 1, 0, 'a9633e3507df101d295ccf7b9d1883a891f70602467f24e64e42e6a0024bcb7e', 0),
(6, 'h00000003', '$2y$10$qLYqXDFcxYilIgq4PxyIHOueHLsxDHyQTHe8befT16MMUidCuNism', 'h14086030@gs.ncku.edu.tw', 1, 0, 'a9633e3507df101d295ccf7b9d1883a891f70602467f24e64e42e6a0024bcb7e', 0);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`ID`);

--
-- 資料表索引 `h14086030_log_table`
--
ALTER TABLE `h14086030_log_table`
  ADD PRIMARY KEY (`log_id`);

--
-- 資料表索引 `h14086030_question_table`
--
ALTER TABLE `h14086030_question_table`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `QID` (`QID`);

--
-- 資料表索引 `question_table`
--
ALTER TABLE `question_table`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `announcement`
--
ALTER TABLE `announcement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `h14086030_log_table`
--
ALTER TABLE `h14086030_log_table`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `h14086030_question_table`
--
ALTER TABLE `h14086030_question_table`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `question_table`
--
ALTER TABLE `question_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=579;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `h14086030_question_table`
--
ALTER TABLE `h14086030_question_table`
  ADD CONSTRAINT `h14086030_question_table_ibfk_1` FOREIGN KEY (`QID`) REFERENCES `question_table` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
