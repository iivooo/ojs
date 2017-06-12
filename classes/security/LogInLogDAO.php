<?php

/**
 * @file classes/security/LogInLogDAO.inc.php
 *
 * @class LogInLogDAO
 * @ingroup security
 * @see Validation
 *
 * @brief Operations for retrieving and inserting log objects.
 */

/**
 * Created by PhpStorm.
 * User: IIvoo
 * Date: 06.06.2017
 * Time: 12:05
 */
class LogInLogDAO extends DAO
{
    var $logInLogDAO;

    function ArticleDAO() {
        parent::DAO();
        //TODO: where to register the dao?
        $this->logInLogDAO =& DAORegistry::getDAO('LogInLogDAO');
    }
}