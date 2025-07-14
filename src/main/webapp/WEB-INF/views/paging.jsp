<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page_number_wrap">
	<div class="page_number_center">
		<button>&lt;&lt;</button>
		<button>&lt;</button>
		
		
		<button class="<c:out value="${color}"/>_background">1</button>
		<button>2</button>
		<button>3</button>
		<button>4</button>
		<button>5</button>
		<button>&gt;</button>
		<button>&gt;&gt;</button>
	</div>
</div>