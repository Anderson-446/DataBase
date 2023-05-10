CREATE SCHEMA `database` DEFAULT CHARACTER SET utf8 ;
USE `database` ;


CREATE TABLE `database`.`USERS` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_username` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(100) NOT NULL,
  `user_password` VARCHAR(255) NOT NULL,
  `type` ENUM('adm', 'com') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`user_email` ASC) VISIBLE
  );


CREATE TABLE `database`.`POSTS` (
  `post_id` INT NOT NULL AUTO_INCREMENT, 
  `post_titulo` VARCHAR(255) NOT NULL,
  `post_conteudo` MEDIUMTEXT NOT NULL,
  `post_data` DATETIME(6) NOT NULL,
  `USERS_user_id` INT NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `fk_POSTS_USERS1_idx` (`USERS_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_POSTS_USERS1`
    FOREIGN KEY (`USERS_user_id`)
    REFERENCES `database`.`USERS` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


CREATE TABLE `database`.`COMMENTS` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment_text` TEXT(500) NOT NULL,
  `comment_data` DATETIME(6) NOT NULL,
  `USERS_user_id` INT NOT NULL,
  `POSTS_post_id` INT NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_COMMENTS_USERS1_idx` (`USERS_user_id` ASC) VISIBLE,
  INDEX `fk_COMMENTS_POSTS1_idx` (`POSTS_post_id` ASC) VISIBLE,
  CONSTRAINT `fk_COMMENTS_USERS1` -- foreing key + tabela primary + tabela foreign
    FOREIGN KEY (`USERS_user_id`)
    REFERENCES `database`.`USERS` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMENTS_POSTS1`
    FOREIGN KEY (`POSTS_post_id`)
    REFERENCES `database`.`POSTS` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


CREATE TABLE `database`.`TAGS` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`)
  );


CREATE TABLE `database`.`TAGGING` (
  `POSTS_post_id` INT NOT NULL,
  `TAGS_tag_id` INT NOT NULL,
  PRIMARY KEY (`POSTS_post_id`, `TAGS_tag_id`),
  INDEX `fk_POSTS_has_TAGS_TAGS1_idx` (`TAGS_tag_id` ASC) VISIBLE,
  INDEX `fk_POSTS_has_TAGS_POSTS1_idx` (`POSTS_post_id` ASC) VISIBLE,
  CONSTRAINT `fk_POSTS_has_TAGS_POSTS1`
    FOREIGN KEY (`POSTS_post_id`)
    REFERENCES `database`.`POSTS` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_POSTS_has_TAGS_TAGS1`
    FOREIGN KEY (`TAGS_tag_id`)
    REFERENCES `database`.`TAGS` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;