; ModuleID = 'C:/Users/jackh/Downloads/Matrix_Lab4/Bitwidth/Bitwidth/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_int<8>" = type { %"struct.ap_int_base<8, true>" }
%"struct.ap_int_base<8, true>" = type { %"class.std::ios_base::Init" }
%"class.std::ios_base::Init" = type { i8 }
%"struct.ap_int<16>" = type { %"struct.ap_int_base<16, true>" }
%"struct.ap_int_base<16, true>" = type { %"struct.ssdm_int<16, true>" }
%"struct.ssdm_int<16, true>" = type { i16 }

; Function Attrs: argmemonly noinline willreturn
define void @apatb_matrix_mult_ir([2 x %"struct.ap_int<8>"]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2" %A, [2 x %"struct.ap_int<8>"]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="2" %B, [2 x %"struct.ap_int<16>"]* noalias nocapture nonnull "fpga.decayed.dim.hint"="2" %AB) local_unnamed_addr #0 {
entry:
  %0 = bitcast [2 x %"struct.ap_int<8>"]* %A to [2 x [2 x %"struct.ap_int<8>"]]*
  %A_copy = alloca [2 x [2 x i8]], align 512
  %1 = bitcast [2 x %"struct.ap_int<8>"]* %B to [2 x [2 x %"struct.ap_int<8>"]]*
  %B_copy = alloca [2 x [2 x i8]], align 512
  %2 = bitcast [2 x %"struct.ap_int<16>"]* %AB to [2 x [2 x %"struct.ap_int<16>"]]*
  %AB_copy = alloca [2 x [2 x i16]], align 512
  call fastcc void @copy_in([2 x [2 x %"struct.ap_int<8>"]]* nonnull %0, [2 x [2 x i8]]* nonnull align 512 %A_copy, [2 x [2 x %"struct.ap_int<8>"]]* nonnull %1, [2 x [2 x i8]]* nonnull align 512 %B_copy, [2 x [2 x %"struct.ap_int<16>"]]* nonnull %2, [2 x [2 x i16]]* nonnull align 512 %AB_copy)
  call void @apatb_matrix_mult_hw([2 x [2 x i8]]* %A_copy, [2 x [2 x i8]]* %B_copy, [2 x [2 x i16]]* %AB_copy)
  call void @copy_back([2 x [2 x %"struct.ap_int<8>"]]* %0, [2 x [2 x i8]]* %A_copy, [2 x [2 x %"struct.ap_int<8>"]]* %1, [2 x [2 x i8]]* %B_copy, [2 x [2 x %"struct.ap_int<16>"]]* %2, [2 x [2 x i16]]* %AB_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([2 x [2 x %"struct.ap_int<8>"]]* noalias readonly, [2 x [2 x i8]]* noalias align 512, [2 x [2 x %"struct.ap_int<8>"]]* noalias readonly, [2 x [2 x i8]]* noalias align 512, [2 x [2 x %"struct.ap_int<16>"]]* noalias readonly, [2 x [2 x i16]]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<8>"([2 x [2 x i8]]* align 512 %1, [2 x [2 x %"struct.ap_int<8>"]]* %0)
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<8>"([2 x [2 x i8]]* align 512 %3, [2 x [2 x %"struct.ap_int<8>"]]* %2)
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<16>"([2 x [2 x i16]]* align 512 %5, [2 x [2 x %"struct.ap_int<16>"]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<8>"([2 x %"struct.ap_int<8>"]* %dst, [2 x %"struct.ap_int<8>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<8>"]* %src, null
  %1 = icmp eq [2 x %"struct.ap_int<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2 x %"struct.ap_int<8>"], [2 x %"struct.ap_int<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [2 x %"struct.ap_int<8>"], [2 x %"struct.ap_int<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %3, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<16>"([2 x [2 x i16]]* noalias align 512 %dst, [2 x [2 x %"struct.ap_int<16>"]]* noalias readonly %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x [2 x i16]]* %dst, null
  %1 = icmp eq [2 x [2 x %"struct.ap_int<16>"]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2a2struct.ap_int<16>"([2 x [2 x i16]]* nonnull %dst, [2 x [2 x %"struct.ap_int<16>"]]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2a2struct.ap_int<16>"([2 x [2 x i16]]* %dst, [2 x [2 x %"struct.ap_int<16>"]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x [2 x %"struct.ap_int<16>"]]* %src, null
  %1 = icmp eq [2 x [2 x i16]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [2 x [2 x i16]], [2 x [2 x i16]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [2 x [2 x %"struct.ap_int<16>"]], [2 x [2 x %"struct.ap_int<16>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a2struct.ap_int<16>"([2 x i16]* %3, [2 x %"struct.ap_int<16>"]* %src.addr, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<16>"([2 x i16]* %dst, [2 x %"struct.ap_int<16>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<16>"]* %src, null
  %1 = icmp eq [2 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2 x %"struct.ap_int<16>"], [2 x %"struct.ap_int<16>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [2 x i16], [2 x i16]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i16, i16* %src.addr.0.0.05, align 2
  store i16 %4, i16* %3, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([2 x [2 x %"struct.ap_int<8>"]]* noalias, [2 x [2 x i8]]* noalias readonly align 512, [2 x [2 x %"struct.ap_int<8>"]]* noalias, [2 x [2 x i8]]* noalias readonly align 512, [2 x [2 x %"struct.ap_int<16>"]]* noalias, [2 x [2 x i16]]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<8>.30"([2 x [2 x %"struct.ap_int<8>"]]* %0, [2 x [2 x i8]]* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<8>.30"([2 x [2 x %"struct.ap_int<8>"]]* %2, [2 x [2 x i8]]* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<16>.6"([2 x [2 x %"struct.ap_int<16>"]]* %4, [2 x [2 x i16]]* align 512 %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<16>.6"([2 x [2 x %"struct.ap_int<16>"]]* noalias %dst, [2 x [2 x i16]]* noalias readonly align 512 %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x [2 x %"struct.ap_int<16>"]]* %dst, null
  %1 = icmp eq [2 x [2 x i16]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2a2struct.ap_int<16>.9"([2 x [2 x %"struct.ap_int<16>"]]* nonnull %dst, [2 x [2 x i16]]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2a2struct.ap_int<16>.9"([2 x [2 x %"struct.ap_int<16>"]]* %dst, [2 x [2 x i16]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x [2 x i16]]* %src, null
  %1 = icmp eq [2 x [2 x %"struct.ap_int<16>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [2 x [2 x %"struct.ap_int<16>"]], [2 x [2 x %"struct.ap_int<16>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [2 x [2 x i16]], [2 x [2 x i16]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a2struct.ap_int<16>.12"([2 x %"struct.ap_int<16>"]* %dst.addr, [2 x i16]* %3, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<16>.12"([2 x %"struct.ap_int<16>"]* %dst, [2 x i16]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x i16]* %src, null
  %1 = icmp eq [2 x %"struct.ap_int<16>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [2 x i16], [2 x i16]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [2 x %"struct.ap_int<16>"], [2 x %"struct.ap_int<16>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i16, i16* %3, align 2
  store i16 %4, i16* %dst.addr.0.0.06, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<8>"([2 x [2 x i8]]* noalias align 512 %dst, [2 x [2 x %"struct.ap_int<8>"]]* noalias readonly %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x [2 x i8]]* %dst, null
  %1 = icmp eq [2 x [2 x %"struct.ap_int<8>"]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2a2struct.ap_int<8>.23"([2 x [2 x i8]]* nonnull %dst, [2 x [2 x %"struct.ap_int<8>"]]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2a2struct.ap_int<8>.23"([2 x [2 x i8]]* %dst, [2 x [2 x %"struct.ap_int<8>"]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x [2 x %"struct.ap_int<8>"]]* %src, null
  %1 = icmp eq [2 x [2 x i8]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [2 x [2 x i8]], [2 x [2 x i8]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [2 x [2 x %"struct.ap_int<8>"]], [2 x [2 x %"struct.ap_int<8>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a2struct.ap_int<8>.26"([2 x i8]* %3, [2 x %"struct.ap_int<8>"]* %src.addr, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<8>.26"([2 x i8]* %dst, [2 x %"struct.ap_int<8>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<8>"]* %src, null
  %1 = icmp eq [2 x i8]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2 x %"struct.ap_int<8>"], [2 x %"struct.ap_int<8>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [2 x i8], [2 x i8]* %dst, i64 0, i64 %for.loop.idx8
  %4 = load i8, i8* %src.addr.0.0.05, align 1
  store i8 %4, i8* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<8>.30"([2 x [2 x %"struct.ap_int<8>"]]* noalias %dst, [2 x [2 x i8]]* noalias readonly align 512 %src) unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x [2 x %"struct.ap_int<8>"]]* %dst, null
  %1 = icmp eq [2 x [2 x i8]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2a2struct.ap_int<8>.33"([2 x [2 x %"struct.ap_int<8>"]]* nonnull %dst, [2 x [2 x i8]]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2a2struct.ap_int<8>.33"([2 x [2 x %"struct.ap_int<8>"]]* %dst, [2 x [2 x i8]]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x [2 x i8]]* %src, null
  %1 = icmp eq [2 x [2 x %"struct.ap_int<8>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [2 x [2 x %"struct.ap_int<8>"]], [2 x [2 x %"struct.ap_int<8>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [2 x [2 x i8]], [2 x [2 x i8]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a2struct.ap_int<8>.36"([2 x %"struct.ap_int<8>"]* %dst.addr, [2 x i8]* %3, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<8>.36"([2 x %"struct.ap_int<8>"]* %dst, [2 x i8]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [2 x i8]* %src, null
  %1 = icmp eq [2 x %"struct.ap_int<8>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [2 x i8], [2 x i8]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [2 x %"struct.ap_int<8>"], [2 x %"struct.ap_int<8>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i8, i8* %3, align 1
  store i8 %4, i8* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_matrix_mult_hw([2 x [2 x i8]]*, [2 x [2 x i8]]*, [2 x [2 x i16]]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([2 x [2 x %"struct.ap_int<8>"]]* noalias, [2 x [2 x i8]]* noalias readonly align 512, [2 x [2 x %"struct.ap_int<8>"]]* noalias, [2 x [2 x i8]]* noalias readonly align 512, [2 x [2 x %"struct.ap_int<16>"]]* noalias, [2 x [2 x i16]]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a2a2struct.ap_int<16>.6"([2 x [2 x %"struct.ap_int<16>"]]* %4, [2 x [2 x i16]]* align 512 %5)
  ret void
}

declare void @matrix_mult_hw_stub([2 x %"struct.ap_int<8>"]* noalias nocapture nonnull readonly, [2 x %"struct.ap_int<8>"]* noalias nocapture nonnull readonly, [2 x %"struct.ap_int<16>"]* noalias nocapture nonnull)

define void @matrix_mult_hw_stub_wrapper([2 x [2 x i8]]*, [2 x [2 x i8]]*, [2 x [2 x i16]]*) #5 {
entry:
  %3 = call i8* @malloc(i64 4)
  %4 = bitcast i8* %3 to [2 x [2 x %"struct.ap_int<8>"]]*
  %5 = call i8* @malloc(i64 4)
  %6 = bitcast i8* %5 to [2 x [2 x %"struct.ap_int<8>"]]*
  %7 = call i8* @malloc(i64 8)
  %8 = bitcast i8* %7 to [2 x [2 x %"struct.ap_int<16>"]]*
  call void @copy_out([2 x [2 x %"struct.ap_int<8>"]]* %4, [2 x [2 x i8]]* %0, [2 x [2 x %"struct.ap_int<8>"]]* %6, [2 x [2 x i8]]* %1, [2 x [2 x %"struct.ap_int<16>"]]* %8, [2 x [2 x i16]]* %2)
  %9 = bitcast [2 x [2 x %"struct.ap_int<8>"]]* %4 to [2 x %"struct.ap_int<8>"]*
  %10 = bitcast [2 x [2 x %"struct.ap_int<8>"]]* %6 to [2 x %"struct.ap_int<8>"]*
  %11 = bitcast [2 x [2 x %"struct.ap_int<16>"]]* %8 to [2 x %"struct.ap_int<16>"]*
  call void @matrix_mult_hw_stub([2 x %"struct.ap_int<8>"]* %9, [2 x %"struct.ap_int<8>"]* %10, [2 x %"struct.ap_int<16>"]* %11)
  call void @copy_in([2 x [2 x %"struct.ap_int<8>"]]* %4, [2 x [2 x i8]]* %0, [2 x [2 x %"struct.ap_int<8>"]]* %6, [2 x [2 x i8]]* %1, [2 x [2 x %"struct.ap_int<16>"]]* %8, [2 x [2 x i16]]* %2)
  call void @free(i8* %3)
  call void @free(i8* %5)
  call void @free(i8* %7)
  ret void
}

attributes #0 = { argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
