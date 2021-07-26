; ModuleID = 'hello.bc'
source_filename = "hello.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.name = type { void (i8*)* }

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [20 x i8] c"call print my name\0A\00", align 1
@.str.2 = private unnamed_addr constant [38 x i8] c"addr of a: %lx. addr of a[12]: %lx. \0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @myprint(i8*) #0 !dbg !7 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  call void @llvm.dbg.declare(metadata i8** %2, metadata !12, metadata !DIExpression()), !dbg !13
  %3 = load i8*, i8** %2, align 8, !dbg !14
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i8* %3), !dbg !15
  ret void, !dbg !16
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @printmyname() #0 !dbg !17 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.1, i32 0, i32 0)), !dbg !20
  ret void, !dbg !21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32, i8**) #0 !dbg !22 {
  %3 = alloca i32, align 4
  %4 = alloca i8**, align 8
  %5 = alloca [10 x %struct.name], align 16
  %6 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !27, metadata !DIExpression()), !dbg !28
  store i8** %1, i8*** %4, align 8
  call void @llvm.dbg.declare(metadata i8*** %4, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata [10 x %struct.name]* %5, metadata !31, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.declare(metadata i32* %6, metadata !41, metadata !DIExpression()), !dbg !42
  store i32 11, i32* %6, align 4, !dbg !42
  %7 = getelementptr inbounds [10 x %struct.name], [10 x %struct.name]* %5, i64 0, i64 12, !dbg !43
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.2, i32 0, i32 0), [10 x %struct.name]* %5, %struct.name* %7), !dbg !44
  %9 = getelementptr inbounds [10 x %struct.name], [10 x %struct.name]* %5, i64 0, i64 12, !dbg !45
  %10 = getelementptr inbounds %struct.name, %struct.name* %9, i32 0, i32 0, !dbg !46
  store void (i8*)* @myprint, void (i8*)** %10, align 16, !dbg !47
  ret i32 0, !dbg !48
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0-3~ubuntu0.18.04.1 (tags/RELEASE_700/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "hello.c", directory: "/home/beverly/Documents/klee/examples/Pointer_SE_samples")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.0-3~ubuntu0.18.04.1 (tags/RELEASE_700/final)"}
!7 = distinct !DISubprogram(name: "myprint", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DILocalVariable(name: "str", arg: 1, scope: !7, file: !1, line: 12, type: !10)
!13 = !DILocation(line: 12, column: 20, scope: !7)
!14 = !DILocation(line: 12, column: 42, scope: !7)
!15 = !DILocation(line: 12, column: 27, scope: !7)
!16 = !DILocation(line: 12, column: 48, scope: !7)
!17 = distinct !DISubprogram(name: "printmyname", scope: !1, file: !1, line: 13, type: !18, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !0, retainedNodes: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{null}
!20 = !DILocation(line: 13, column: 22, scope: !17)
!21 = !DILocation(line: 13, column: 54, scope: !17)
!22 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !23, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!25, !25, !26}
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!27 = !DILocalVariable(name: "argc", arg: 1, scope: !22, file: !1, line: 15, type: !25)
!28 = !DILocation(line: 15, column: 14, scope: !22)
!29 = !DILocalVariable(name: "argv", arg: 2, scope: !22, file: !1, line: 15, type: !26)
!30 = !DILocation(line: 15, column: 26, scope: !22)
!31 = !DILocalVariable(name: "a", scope: !22, file: !1, line: 16, type: !32)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 640, elements: !38)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "NAME", file: !1, line: 10, baseType: !34)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "name", file: !1, line: 7, size: 64, elements: !35)
!35 = !{!36}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "func", scope: !34, file: !1, line: 9, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!38 = !{!39}
!39 = !DISubrange(count: 10)
!40 = !DILocation(line: 16, column: 10, scope: !22)
!41 = !DILocalVariable(name: "idx", scope: !22, file: !1, line: 17, type: !25)
!42 = !DILocation(line: 17, column: 9, scope: !22)
!43 = !DILocation(line: 18, column: 60, scope: !22)
!44 = !DILocation(line: 18, column: 5, scope: !22)
!45 = !DILocation(line: 19, column: 5, scope: !22)
!46 = !DILocation(line: 19, column: 11, scope: !22)
!47 = !DILocation(line: 19, column: 16, scope: !22)
!48 = !DILocation(line: 94, column: 1, scope: !22)
