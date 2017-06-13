SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `captcheck`.`sessions` 
ADD COLUMN `acqid` INT(11) NOT NULL AFTER `aid`,
ADD INDEX `fk_sessions_access_qa1_idx` (`acqid` ASC);

CREATE TABLE IF NOT EXISTS `captcheck`.`access_questions` (
  `acqid` INT(11) NOT NULL AUTO_INCREMENT,
  `acqtext` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`acqid`),
  UNIQUE INDEX `qaid_UNIQUE` (`acqid` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `captcheck`.`access_answers` (
  `acaid` INT(11) NOT NULL AUTO_INCREMENT,
  `acqid` INT(11) NOT NULL,
  `acatext` VARCHAR(45) NULL DEFAULT NULL,
  `acahash` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`acaid`, `acqid`),
  UNIQUE INDEX `acaid_UNIQUE` (`acaid` ASC),
  INDEX `fk_access_answers_access_questions1_idx` (`acqid` ASC),
  CONSTRAINT `fk_access_answers_access_questions1`
    FOREIGN KEY (`acqid`)
    REFERENCES `captcheck`.`access_questions` (`acqid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `captcheck`.`sessions` 
ADD CONSTRAINT `fk_sessions_access_qa1`
  FOREIGN KEY (`acqid`)
  REFERENCES `captcheck`.`access_questions` (`acqid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `captcheck`.`access_questions`
-- -----------------------------------------------------
START TRANSACTION;
USE `captcheck`;
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (1, 'The list pink, yellow, library and purple contains how many colours?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (2, 'If the sock is black, what colour is it?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (3, 'Rice, bee and green: how many colours in the list?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (4, 'Enter the lowest number of seventy four, six or 73:');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (5, '67, twelve, fifty, 34, thirty or thirteen: which of these is the largest?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (6, '48, sixty six, eighty seven, sixty nine, twenty seven or 69: the largest is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (7, '39, twenty two, thirteen and 19: the 3rd number is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (8, 'What number is 1st in the series fourteen, 34, 1, 24 and thirty six?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (9, 'Enter the number eighty three thousand six hundred and thirty one in digits:');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (10, 'Enter the number seventy seven thousand and fifty in digits:');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (11, 'What is the 7th digit in 5044750?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (12, 'Which digit is 7th in the number 6172149?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (13, 'What is the 2nd colour in the list black, rice, sock, tongue and green?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (14, 'What is sixty seven thousand one hundred and eighty six as digits?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (15, 'Which of ten, fifty nine or fifty four is the highest?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (16, 'The list rainjacket, hand, brown and tracksuit contains how many colours?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (17, 'The list thumb, bread, arm, church, glove and shark contains how many body parts?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (18, 'The 1st number from 32, 5 and twenty three is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (19, 'What is seventy four thousand and three as digits?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (20, 'Fifteen - four equals ?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (21, 'Enter the biggest number of eleven, ninety, 58 or 84:');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (22, 'If the trousers is green, what colour is it?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (23, 'The 1st number from six, twenty four and twenty two is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (24, 'Enter the number twenty thousand six hundred and five in digits:');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (25, 'If a person is called Elizabeth, what is their name?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (26, 'If tomorrow is Tuesday, what day is today?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (27, 'Six plus 10 is what?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (28, '83, seventy seven or forty one: the smallest is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (29, 'In the number 2244803, what is the 1st digit?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (30, 'Steven\'s name is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (31, 'The list house, finger, eye and stomach contains how many body parts?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (32, 'What is the 2nd digit in 3658990?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (33, 'If the rainjacket is red, what colour is it?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (34, 'Of the numbers fifty nine, 21, 51, fourteen or 6, which is the biggest?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (35, 'The name of Elizabeth is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (36, 'The purple cake is what colour?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (37, 'The 2nd colour in white, ear, pink, red, fruit and brown is?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (38, 'What is the 1st colour in the list butter, red, purple and snake?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (39, 'What is the 3rd digit in 8705374?');
INSERT INTO `captcheck`.`access_questions` (`acqid`, `acqtext`) VALUES (40, 'What is fifty nine thousand five hundred and seven as a number?');

COMMIT;


-- -----------------------------------------------------
-- Data for table `captcheck`.`access_answers`
-- -----------------------------------------------------
START TRANSACTION;
USE `captcheck`;
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (1, 1, 'NULL', 'eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (2, 1, 'NULL', '35d6d33467aae9a2e3dccb4b6b027878');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (3, 2, 'NULL', '1ffd9e753c8054cc61456ac7fac1ac89');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (4, 3, 'NULL', 'c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (5, 3, 'NULL', 'f97c5d29941bfb1b2fdab0874906ab82');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (6, 4, 'NULL', '1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (7, 4, 'NULL', 'f52b5e449a2303c031a0c3a1109360bf');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (8, 5, 'NULL', '735b90b4568125ed6c3f678819b6e058');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (9, 5, 'NULL', 'bd8c596e0540a2e53362ffd8e83c0af1');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (10, 6, 'NULL', 'c7e1249ffc03eb9ded908c236bd1996d');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (11, 6, 'NULL', 'a3862f91f724b3ba93c0d29d596091aa');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (12, 7, 'NULL', 'c51ce410c124a10e0db5e4b97fc2af39');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (13, 7, 'NULL', '422ecc084f2458defc620ecebf2a6448');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (14, 8, 'NULL', 'aab3238922bcc25a6f606eb525ffdc56');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (15, 8, 'NULL', '279e962ea623aa2a3a86739622772e1f');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (16, 9, 'NULL', '99e8619d83ef705cde096f1413284f9d');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (17, 10, 'NULL', '2c078e4b2c48fa83a11b825008177059');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (18, 11, 'NULL', 'cfcd208495d565ef66e7dff9f98764da');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (19, 11, 'NULL', 'd02c4c4cde7ae76252540d116a40f23a');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (20, 12, 'NULL', '45c48cce2e2d7fbdea1afc51c7c6ad26');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (21, 12, 'NULL', 'c785e1ed2950e3e36b1e2ca01f299a54');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (22, 13, 'NULL', '9f27410725ab8cc8854a2769c7a516b8');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (23, 14, 'NULL', '2a21883121a4da3cb0c12e42bf1ab4f9');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (24, 15, 'NULL', '093f65e080a295f8076b1c5722a46aa2');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (25, 15, 'NULL', '674573a74de9d057c6c5a70819b12f5f');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (26, 16, 'NULL', 'c4ca4238a0b923820dcc509a6f75849b');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (27, 16, 'NULL', 'f97c5d29941bfb1b2fdab0874906ab82');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (28, 17, 'NULL', 'c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (29, 17, 'NULL', 'b8a9f715dbb64fd5c56e7783c6820a61');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (30, 18, 'NULL', '6364d3f0f495b6ab9dcf8d3b5c6e0b01');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (31, 18, 'NULL', '8cb16a6da2f0587a3a2b614040dbd2cf');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (32, 19, 'NULL', '1180362fa4d3626eec0aacebeafbe5fc');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (33, 20, 'NULL', '6512bd43d9caa6e02c990b0a82652dca');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (34, 20, 'NULL', '9c8454ddf7aa50116496bac348d7550d');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (35, 21, 'NULL', '8613985ec49eb8f757ae6439e879bb2a');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (36, 21, 'NULL', '2a08e96cadfba8bfb49c392bd4ec27a7');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (37, 22, 'NULL', '9f27410725ab8cc8854a2769c7a516b8');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (38, 23, 'NULL', '1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (39, 23, 'NULL', 'f52b5e449a2303c031a0c3a1109360bf');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (40, 24, 'NULL', '1b4f877baadb44b36ff73a44e05ebd4c');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (41, 25, 'NULL', '4af09080574089cbece43db636e2025f');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (42, 26, 'NULL', '944ba223a5c1b5f4b495708e7cd5ee37');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (43, 26, 'NULL', '197639b278057c519189add5413712e3');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (44, 27, 'NULL', 'c74d97b01eae257e44aa9d5bade97baf');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (45, 27, 'NULL', 'bd2c775d9eaf5f71da52b55ade9989a4');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (46, 28, 'NULL', '3416a75f4cea9109507cacd8e2f2aefc');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (47, 28, 'NULL', '7b6cd20827f5a8a4576ef68f45a4ef32');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (48, 29, 'NULL', 'c81e728d9d4c2f636f067f89cc14862c');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (49, 29, 'NULL', 'b8a9f715dbb64fd5c56e7783c6820a61');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (50, 30, 'NULL', '6ed61d4b80bb0f81937b32418e98adca');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (51, 31, 'NULL', 'eccbc87e4b5ce2fe28308fd9f2a7baf3');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (52, 31, 'NULL', '35d6d33467aae9a2e3dccb4b6b027878');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (53, 32, 'NULL', '1679091c5a880faf6fb5e6087eb1b2dc');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (54, 32, 'NULL', 'f52b5e449a2303c031a0c3a1109360bf');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (55, 33, 'NULL', 'bda9643ac6601722a28f238714274da4');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (56, 34, 'NULL', '093f65e080a295f8076b1c5722a46aa2');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (57, 34, 'NULL', '674573a74de9d057c6c5a70819b12f5f');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (58, 35, 'NULL', '4af09080574089cbece43db636e2025f');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (59, 36, 'NULL', 'bb7aedfa61007447dd6efaf9f37641e3');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (60, 37, 'NULL', '4a0b0dcedd48f780778d1cd1bb8f9877');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (61, 38, 'NULL', 'bda9643ac6601722a28f238714274da4');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (62, 39, 'NULL', 'cfcd208495d565ef66e7dff9f98764da');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (63, 39, 'NULL', 'd02c4c4cde7ae76252540d116a40f23a');
INSERT INTO `captcheck`.`access_answers` (`acaid`, `acqid`, `acatext`, `acahash`) VALUES (64, 40, 'NULL', '454cba7bd267c3f60d982416d06516f6');

COMMIT;