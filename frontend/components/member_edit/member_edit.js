import "@fengyuanchen/datepicker";
import "./member_edit.css";

const $ = require("jquery");

$("#member_date_from").datepicker({ format: "dd/mm/yyyy" });
$("#member_date_to").datepicker({ format: "dd/mm/yyyy" });
