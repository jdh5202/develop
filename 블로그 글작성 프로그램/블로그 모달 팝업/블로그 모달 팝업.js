<style>

    /* contents */
    .content {display: none;position:fixed; top: 0; margin-left: -25%; width: 100%;height: 100%; background: rgba(0,0,0,0.9);}
    .content .close {position:fixed; top: 20px; right: 20px;}
    .content .close img {margin-top: 7%; margin-left: 1000px; width: 32px; height: 32px;}
    .content div {position: fixed; top: 28%; left: -19%;  margin-top: -150px; margin-left: 25%; padding: 20px 2%; height: 660px; width: 85%; overflow-y: auto;display: none;  background: #fff;  }
    .content div.open {display: block;}
  </style>

  <div class="content">
    <p class="close"><a href=""><img src="https://www.astri.org/wp-content/uploads/home/x.png" alt=""></a></p>
 <div id="a1">

    <div class="txc-textbox" style="BORDER-TOP: #eeeeee 1px solid; BORDER-RIGHT: #eeeeee 1px solid; BORDER-BOTTOM: #eeeeee 1px solid; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; PADDING-LEFT: 14px; BORDER-LEFT: #eeeeee 1px solid; PADDING-RIGHT: 14px; BACKGROUND-COLOR: #eeeeee"><strong><span style="font-size: 16pt;">? IDA View<br /></span></strong></div> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; Graph view - ���α׷� �帧�� �ٲ�°� �����ش�.( ���� jxx ���� )<br /></b></span><hr> �б� - �� = �ʷϻ� ȭ��ǥ<br /> - ���� = ������ ȭ��ǥ<br /> - ������ = �Ķ��� ȭ��ǥ<br /> <br /> <span style="display:inline-block;border-top:thick double skyblue;border-bottom:thick double skyblue;padding-bottom : 2px;font-size:14pt;"><font color="#0d1a81"><b> View - Graphs - xrefs to<br /></b></font></span> Ư�� �Լ��� �����ϴ� ��� ��츦 �׷����� �����ش�.<br /> <br /> <span style="display:inline-block;border-top:thick double skyblue;border-bottom:thick double skyblue;padding-bottom : 2px;font-size:14pt;"><font color="#0d1a81"><b> View - Graphs - xrefs from<br /></b></font></span> �Լ����� ȣ���ϴ� �Լ����� �����Ѵ�.<br /> <br /> <font size="4pt"><b>? ����� ���� = ���̺귯��<br /></b></font> <br /> ��� ����� �Լ� �帧�� �׷����� �����ش�.<br /> <br /> user xrefs chart�� �� ����� ���ÿ� ����Ѵ�.<br /> <br /> depth�� -1���ϸ� �̵� Ƚ���� ���� ���� ���� �����ָ�, <br /> <br /> externals üũ�� ���̺귯���Լ��� �Ⱥ��δ�.<br /> <br /> <font size="4pt"><b>? graph view �ּ� ���¹� option -&gt; general -&gt; disassembly -&gt; line prefixes üũ<br /></b></font> <br /> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; String view - ���α׷� ���� ��� ���ڿ��� ã�� �����ش�.<br /></b></span><hr> ���� : view -&gt; open subviews -strings<br /> <br /> ��Ŭ�� - setup���� allowd string types�� ��� ������ָ� �� �� ã����<br /> Ignore instruction/data definition�� üũ���ָ� ��ɾ �����Ͷ� �����Ǵ� ���ڿ��� ã�´�.<br /> <br /> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; hex view<br /></b></span><hr> <br /> IDA view-A�� Hex view-A�� Ŀ����ġ �������� ����ȭ�Ǿ�����.<br /> �� IDA view-A���� Ŀ���� 100�ּҸ� ����Ű�� ������ <br /> Hex view-A�� �Ȱ��� �ش� �ּҸ� ����Ű�� �ִ�.<br /> <br /> �ش� ������ ��Ŭ�� - synchronize with���� ���氡���ϴ�.<br /> <br /> <font size="4pt"><b>? view ��ȯ�� : Space bar<br /></b></font> <br /> <br /> <div class="txc-textbox" style="BORDER-TOP: #eeeeee 1px solid; BORDER-RIGHT: #eeeeee 1px solid; BORDER-BOTTOM: #eeeeee 1px solid; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; PADDING-LEFT: 14px; BORDER-LEFT: #eeeeee 1px solid; PADDING-RIGHT: 14px; BACKGROUND-COLOR: #eeeeee"><strong><span style="font-size: 16pt;">? IDA ���<br /></span></strong></div> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; Debuging<br /></b></span><hr> Local win32 Debugger - ���� ��ǻ�Ϳ��� �����<br /> <br /> F2: BP ����<br /> F7: step into<br /> F8: step over<br /> <br /> <span style="background-color: blue;color:blue;display:inline-block;border-top:thick double #66FF99;border-bottom:thick double #66FF99;padding-bottom : 1px;font-size:16pt;">&nbsp;&nbsp;</span><span style="font-size:16pt;"><b>&nbsp; Decompiler<br /></b></span><hr> �ش� �Լ����� F5�� ������ �������ϵǸ� , �Լ������θ� ��� �����ϴ�.<br /> <br /> <br /> <div class="txc-textbox" style="BORDER-TOP: #eeeeee 1px solid; BORDER-RIGHT: #eeeeee 1px solid; BORDER-BOTTOM: #eeeeee 1px solid; PADDING-BOTTOM: 14px; PADDING-TOP: 14px; PADDING-LEFT: 14px; BORDER-LEFT: #eeeeee 1px solid; PADDING-RIGHT: 14px; BACKGROUND-COLOR: #eeeeee"><strong><span style="font-size: 16pt;">? IDA ����<br /></span></strong></div> IDA�� �۾� �� ���� ���������� �ƴ� idb��� �����ͺ��̽��� �۾��� �ϰ� �ȴ�.<br /> IDA�� �����Ϸ��� �ϴ� ��� IDA � ������� �������� â�� �߰� �Ǵµ�<br /> IDA�� ������ id0 id1 nam til ���ϵ��� idb ���Ϸ� ������ �����Ѵ�.<br /> <br /> Don't Pack Database = ������ �����ʰڴ�.<br /> Pack Database(Store,Deflate) = ������ ���ڴ�.<br /> Don'T SAVE the database = �۾� ������ �������� �ʴ´�.<br /> <br /> <font size="4pt"><b>? �⺻ ���� �� = Pack Database<br /></b></font> </div>

    <p id="a2">
      ����2
    </p>
    <p id="a3">
      ����3
    </p>
    <p id="a4">
      ����4
    </p>
  </div><strong>
  <script>
    $(window).on('hashchange', function(){
      $('.content').css('display', 'block');
      $(':target').addClass('open');
    });
  </script>