; ModuleID = './test.bc'
source_filename = "test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"r: %d, c: %d. \0A\00", align 1
@.str.1 = private unnamed_addr constant [30 x i8] c"moves: %lx. r: %d. c-1: %d. \0A\00", align 1
@.str.2 = private unnamed_addr constant [27 x i8] c"-------------------  %x, \0A\00", align 1
@.str.3 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str.1.4 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str.2.5 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %3, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 0, i32* %2, align 4, !dbg !17
  br label %5, !dbg !19

5:                                                ; preds = %498, %0
  %6 = load i32, i32* %2, align 4, !dbg !20
  %7 = icmp slt i32 %6, 8, !dbg !22
  br i1 %7, label %8, label %501, !dbg !23

8:                                                ; preds = %5
  store i32 0, i32* %3, align 4, !dbg !24
  br label %9, !dbg !26

9:                                                ; preds = %494, %8
  %10 = load i32, i32* %3, align 4, !dbg !27
  %11 = icmp slt i32 %10, 8, !dbg !29
  br i1 %11, label %12, label %497, !dbg !30

12:                                               ; preds = %9
  %13 = load i32, i32* %2, align 4, !dbg !31
  %14 = load i32, i32* %3, align 4, !dbg !33
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0), i32 %13, i32 %14), !dbg !34
  call void @llvm.dbg.declare(metadata i64* %4, metadata !35, metadata !DIExpression()), !dbg !41
  store i64 0, i64* %4, align 8, !dbg !41
  %16 = load i32, i32* %2, align 4, !dbg !42
  %17 = sub nsw i32 %16, 2, !dbg !42
  %18 = icmp sge i32 %17, 0, !dbg !42
  br i1 %18, label %19, label %40, !dbg !42

19:                                               ; preds = %12
  %20 = load i32, i32* %2, align 4, !dbg !42
  %21 = sub nsw i32 %20, 2, !dbg !42
  %22 = icmp sle i32 %21, 7, !dbg !42
  br i1 %22, label %23, label %40, !dbg !42

23:                                               ; preds = %19
  %24 = load i32, i32* %3, align 4, !dbg !42
  %25 = sub nsw i32 %24, 1, !dbg !42
  %26 = icmp sge i32 %25, 0, !dbg !42
  br i1 %26, label %27, label %40, !dbg !42

27:                                               ; preds = %23
  %28 = load i32, i32* %3, align 4, !dbg !42
  %29 = sub nsw i32 %28, 1, !dbg !42
  %30 = icmp sle i32 %29, 7, !dbg !42
  br i1 %30, label %31, label %40, !dbg !42

31:                                               ; preds = %27
  %32 = load i32, i32* %2, align 4, !dbg !42
  %33 = sub nsw i32 %32, 2, !dbg !42
  %34 = mul nsw i32 %33, 8, !dbg !42
  %35 = load i32, i32* %3, align 4, !dbg !42
  %36 = sub nsw i32 %35, 1, !dbg !42
  %37 = add nsw i32 %34, %36, !dbg !42
  %38 = zext i32 %37 to i64, !dbg !42
  call void @klee_overshift_check(i64 64, i64 %38), !dbg !42
  %39 = shl i64 1, %38, !dbg !42, !klee.check.shift !43
  br label %41, !dbg !42

40:                                               ; preds = %27, %23, %19, %12
  br label %41, !dbg !42

41:                                               ; preds = %40, %31
  %42 = phi i64 [ %39, %31 ], [ 0, %40 ], !dbg !42
  %43 = load i64, i64* %4, align 8, !dbg !44
  %44 = or i64 %43, %42, !dbg !44
  store i64 %44, i64* %4, align 8, !dbg !44
  %45 = load i32, i32* %2, align 4, !dbg !45
  %46 = sub nsw i32 %45, 1, !dbg !45
  %47 = icmp sge i32 %46, 0, !dbg !45
  br i1 %47, label %48, label %69, !dbg !45

48:                                               ; preds = %41
  %49 = load i32, i32* %2, align 4, !dbg !45
  %50 = sub nsw i32 %49, 1, !dbg !45
  %51 = icmp sle i32 %50, 7, !dbg !45
  br i1 %51, label %52, label %69, !dbg !45

52:                                               ; preds = %48
  %53 = load i32, i32* %3, align 4, !dbg !45
  %54 = sub nsw i32 %53, 2, !dbg !45
  %55 = icmp sge i32 %54, 0, !dbg !45
  br i1 %55, label %56, label %69, !dbg !45

56:                                               ; preds = %52
  %57 = load i32, i32* %3, align 4, !dbg !45
  %58 = sub nsw i32 %57, 2, !dbg !45
  %59 = icmp sle i32 %58, 7, !dbg !45
  br i1 %59, label %60, label %69, !dbg !45

60:                                               ; preds = %56
  %61 = load i32, i32* %2, align 4, !dbg !45
  %62 = sub nsw i32 %61, 1, !dbg !45
  %63 = mul nsw i32 %62, 8, !dbg !45
  %64 = load i32, i32* %3, align 4, !dbg !45
  %65 = sub nsw i32 %64, 2, !dbg !45
  %66 = add nsw i32 %63, %65, !dbg !45
  %67 = zext i32 %66 to i64, !dbg !45
  call void @klee_overshift_check(i64 64, i64 %67), !dbg !45
  %68 = shl i64 1, %67, !dbg !45, !klee.check.shift !43
  br label %70, !dbg !45

69:                                               ; preds = %56, %52, %48, %41
  br label %70, !dbg !45

70:                                               ; preds = %69, %60
  %71 = phi i64 [ %68, %60 ], [ 0, %69 ], !dbg !45
  %72 = load i64, i64* %4, align 8, !dbg !46
  %73 = or i64 %72, %71, !dbg !46
  store i64 %73, i64* %4, align 8, !dbg !46
  %74 = load i32, i32* %2, align 4, !dbg !47
  %75 = sub nsw i32 %74, 2, !dbg !47
  %76 = icmp sge i32 %75, 0, !dbg !47
  br i1 %76, label %77, label %98, !dbg !47

77:                                               ; preds = %70
  %78 = load i32, i32* %2, align 4, !dbg !47
  %79 = sub nsw i32 %78, 2, !dbg !47
  %80 = icmp sle i32 %79, 7, !dbg !47
  br i1 %80, label %81, label %98, !dbg !47

81:                                               ; preds = %77
  %82 = load i32, i32* %3, align 4, !dbg !47
  %83 = add nsw i32 %82, 1, !dbg !47
  %84 = icmp sge i32 %83, 0, !dbg !47
  br i1 %84, label %85, label %98, !dbg !47

85:                                               ; preds = %81
  %86 = load i32, i32* %3, align 4, !dbg !47
  %87 = add nsw i32 %86, 1, !dbg !47
  %88 = icmp sle i32 %87, 7, !dbg !47
  br i1 %88, label %89, label %98, !dbg !47

89:                                               ; preds = %85
  %90 = load i32, i32* %2, align 4, !dbg !47
  %91 = sub nsw i32 %90, 2, !dbg !47
  %92 = mul nsw i32 %91, 8, !dbg !47
  %93 = load i32, i32* %3, align 4, !dbg !47
  %94 = add nsw i32 %93, 1, !dbg !47
  %95 = add nsw i32 %92, %94, !dbg !47
  %96 = zext i32 %95 to i64, !dbg !47
  call void @klee_overshift_check(i64 64, i64 %96), !dbg !47
  %97 = shl i64 1, %96, !dbg !47, !klee.check.shift !43
  br label %99, !dbg !47

98:                                               ; preds = %85, %81, %77, %70
  br label %99, !dbg !47

99:                                               ; preds = %98, %89
  %100 = phi i64 [ %97, %89 ], [ 0, %98 ], !dbg !47
  %101 = load i64, i64* %4, align 8, !dbg !48
  %102 = or i64 %101, %100, !dbg !48
  store i64 %102, i64* %4, align 8, !dbg !48
  %103 = load i32, i32* %2, align 4, !dbg !49
  %104 = sub nsw i32 %103, 1, !dbg !49
  %105 = icmp sge i32 %104, 0, !dbg !49
  br i1 %105, label %106, label %127, !dbg !49

106:                                              ; preds = %99
  %107 = load i32, i32* %2, align 4, !dbg !49
  %108 = sub nsw i32 %107, 1, !dbg !49
  %109 = icmp sle i32 %108, 7, !dbg !49
  br i1 %109, label %110, label %127, !dbg !49

110:                                              ; preds = %106
  %111 = load i32, i32* %3, align 4, !dbg !49
  %112 = add nsw i32 %111, 2, !dbg !49
  %113 = icmp sge i32 %112, 0, !dbg !49
  br i1 %113, label %114, label %127, !dbg !49

114:                                              ; preds = %110
  %115 = load i32, i32* %3, align 4, !dbg !49
  %116 = add nsw i32 %115, 2, !dbg !49
  %117 = icmp sle i32 %116, 7, !dbg !49
  br i1 %117, label %118, label %127, !dbg !49

118:                                              ; preds = %114
  %119 = load i32, i32* %2, align 4, !dbg !49
  %120 = sub nsw i32 %119, 1, !dbg !49
  %121 = mul nsw i32 %120, 8, !dbg !49
  %122 = load i32, i32* %3, align 4, !dbg !49
  %123 = add nsw i32 %122, 2, !dbg !49
  %124 = add nsw i32 %121, %123, !dbg !49
  %125 = zext i32 %124 to i64, !dbg !49
  call void @klee_overshift_check(i64 64, i64 %125), !dbg !49
  %126 = shl i64 1, %125, !dbg !49, !klee.check.shift !43
  br label %128, !dbg !49

127:                                              ; preds = %114, %110, %106, %99
  br label %128, !dbg !49

128:                                              ; preds = %127, %118
  %129 = phi i64 [ %126, %118 ], [ 0, %127 ], !dbg !49
  %130 = load i64, i64* %4, align 8, !dbg !50
  %131 = or i64 %130, %129, !dbg !50
  store i64 %131, i64* %4, align 8, !dbg !50
  %132 = load i32, i32* %2, align 4, !dbg !51
  %133 = add nsw i32 %132, 2, !dbg !51
  %134 = icmp sge i32 %133, 0, !dbg !51
  br i1 %134, label %135, label %156, !dbg !51

135:                                              ; preds = %128
  %136 = load i32, i32* %2, align 4, !dbg !51
  %137 = add nsw i32 %136, 2, !dbg !51
  %138 = icmp sle i32 %137, 7, !dbg !51
  br i1 %138, label %139, label %156, !dbg !51

139:                                              ; preds = %135
  %140 = load i32, i32* %3, align 4, !dbg !51
  %141 = sub nsw i32 %140, 1, !dbg !51
  %142 = icmp sge i32 %141, 0, !dbg !51
  br i1 %142, label %143, label %156, !dbg !51

143:                                              ; preds = %139
  %144 = load i32, i32* %3, align 4, !dbg !51
  %145 = sub nsw i32 %144, 1, !dbg !51
  %146 = icmp sle i32 %145, 7, !dbg !51
  br i1 %146, label %147, label %156, !dbg !51

147:                                              ; preds = %143
  %148 = load i32, i32* %2, align 4, !dbg !51
  %149 = add nsw i32 %148, 2, !dbg !51
  %150 = mul nsw i32 %149, 8, !dbg !51
  %151 = load i32, i32* %3, align 4, !dbg !51
  %152 = sub nsw i32 %151, 1, !dbg !51
  %153 = add nsw i32 %150, %152, !dbg !51
  %154 = zext i32 %153 to i64, !dbg !51
  call void @klee_overshift_check(i64 64, i64 %154), !dbg !51
  %155 = shl i64 1, %154, !dbg !51, !klee.check.shift !43
  br label %157, !dbg !51

156:                                              ; preds = %143, %139, %135, %128
  br label %157, !dbg !51

157:                                              ; preds = %156, %147
  %158 = phi i64 [ %155, %147 ], [ 0, %156 ], !dbg !51
  %159 = load i64, i64* %4, align 8, !dbg !52
  %160 = or i64 %159, %158, !dbg !52
  store i64 %160, i64* %4, align 8, !dbg !52
  %161 = load i32, i32* %2, align 4, !dbg !53
  %162 = add nsw i32 %161, 1, !dbg !53
  %163 = icmp sge i32 %162, 0, !dbg !53
  br i1 %163, label %164, label %185, !dbg !53

164:                                              ; preds = %157
  %165 = load i32, i32* %2, align 4, !dbg !53
  %166 = add nsw i32 %165, 1, !dbg !53
  %167 = icmp sle i32 %166, 7, !dbg !53
  br i1 %167, label %168, label %185, !dbg !53

168:                                              ; preds = %164
  %169 = load i32, i32* %3, align 4, !dbg !53
  %170 = sub nsw i32 %169, 2, !dbg !53
  %171 = icmp sge i32 %170, 0, !dbg !53
  br i1 %171, label %172, label %185, !dbg !53

172:                                              ; preds = %168
  %173 = load i32, i32* %3, align 4, !dbg !53
  %174 = sub nsw i32 %173, 2, !dbg !53
  %175 = icmp sle i32 %174, 7, !dbg !53
  br i1 %175, label %176, label %185, !dbg !53

176:                                              ; preds = %172
  %177 = load i32, i32* %2, align 4, !dbg !53
  %178 = add nsw i32 %177, 1, !dbg !53
  %179 = mul nsw i32 %178, 8, !dbg !53
  %180 = load i32, i32* %3, align 4, !dbg !53
  %181 = sub nsw i32 %180, 2, !dbg !53
  %182 = add nsw i32 %179, %181, !dbg !53
  %183 = zext i32 %182 to i64, !dbg !53
  call void @klee_overshift_check(i64 64, i64 %183), !dbg !53
  %184 = shl i64 1, %183, !dbg !53, !klee.check.shift !43
  br label %186, !dbg !53

185:                                              ; preds = %172, %168, %164, %157
  br label %186, !dbg !53

186:                                              ; preds = %185, %176
  %187 = phi i64 [ %184, %176 ], [ 0, %185 ], !dbg !53
  %188 = load i64, i64* %4, align 8, !dbg !54
  %189 = or i64 %188, %187, !dbg !54
  store i64 %189, i64* %4, align 8, !dbg !54
  %190 = load i32, i32* %2, align 4, !dbg !55
  %191 = add nsw i32 %190, 2, !dbg !55
  %192 = icmp sge i32 %191, 0, !dbg !55
  br i1 %192, label %193, label %214, !dbg !55

193:                                              ; preds = %186
  %194 = load i32, i32* %2, align 4, !dbg !55
  %195 = add nsw i32 %194, 2, !dbg !55
  %196 = icmp sle i32 %195, 7, !dbg !55
  br i1 %196, label %197, label %214, !dbg !55

197:                                              ; preds = %193
  %198 = load i32, i32* %3, align 4, !dbg !55
  %199 = add nsw i32 %198, 1, !dbg !55
  %200 = icmp sge i32 %199, 0, !dbg !55
  br i1 %200, label %201, label %214, !dbg !55

201:                                              ; preds = %197
  %202 = load i32, i32* %3, align 4, !dbg !55
  %203 = add nsw i32 %202, 1, !dbg !55
  %204 = icmp sle i32 %203, 7, !dbg !55
  br i1 %204, label %205, label %214, !dbg !55

205:                                              ; preds = %201
  %206 = load i32, i32* %2, align 4, !dbg !55
  %207 = add nsw i32 %206, 2, !dbg !55
  %208 = mul nsw i32 %207, 8, !dbg !55
  %209 = load i32, i32* %3, align 4, !dbg !55
  %210 = add nsw i32 %209, 1, !dbg !55
  %211 = add nsw i32 %208, %210, !dbg !55
  %212 = zext i32 %211 to i64, !dbg !55
  call void @klee_overshift_check(i64 64, i64 %212), !dbg !55
  %213 = shl i64 1, %212, !dbg !55, !klee.check.shift !43
  br label %215, !dbg !55

214:                                              ; preds = %201, %197, %193, %186
  br label %215, !dbg !55

215:                                              ; preds = %214, %205
  %216 = phi i64 [ %213, %205 ], [ 0, %214 ], !dbg !55
  %217 = load i64, i64* %4, align 8, !dbg !56
  %218 = or i64 %217, %216, !dbg !56
  store i64 %218, i64* %4, align 8, !dbg !56
  %219 = load i32, i32* %2, align 4, !dbg !57
  %220 = add nsw i32 %219, 1, !dbg !57
  %221 = icmp sge i32 %220, 0, !dbg !57
  br i1 %221, label %222, label %243, !dbg !57

222:                                              ; preds = %215
  %223 = load i32, i32* %2, align 4, !dbg !57
  %224 = add nsw i32 %223, 1, !dbg !57
  %225 = icmp sle i32 %224, 7, !dbg !57
  br i1 %225, label %226, label %243, !dbg !57

226:                                              ; preds = %222
  %227 = load i32, i32* %3, align 4, !dbg !57
  %228 = add nsw i32 %227, 2, !dbg !57
  %229 = icmp sge i32 %228, 0, !dbg !57
  br i1 %229, label %230, label %243, !dbg !57

230:                                              ; preds = %226
  %231 = load i32, i32* %3, align 4, !dbg !57
  %232 = add nsw i32 %231, 2, !dbg !57
  %233 = icmp sle i32 %232, 7, !dbg !57
  br i1 %233, label %234, label %243, !dbg !57

234:                                              ; preds = %230
  %235 = load i32, i32* %2, align 4, !dbg !57
  %236 = add nsw i32 %235, 1, !dbg !57
  %237 = mul nsw i32 %236, 8, !dbg !57
  %238 = load i32, i32* %3, align 4, !dbg !57
  %239 = add nsw i32 %238, 2, !dbg !57
  %240 = add nsw i32 %237, %239, !dbg !57
  %241 = zext i32 %240 to i64, !dbg !57
  call void @klee_overshift_check(i64 64, i64 %241), !dbg !57
  %242 = shl i64 1, %241, !dbg !57, !klee.check.shift !43
  br label %244, !dbg !57

243:                                              ; preds = %230, %226, %222, %215
  br label %244, !dbg !57

244:                                              ; preds = %243, %234
  %245 = phi i64 [ %242, %234 ], [ 0, %243 ], !dbg !57
  %246 = load i64, i64* %4, align 8, !dbg !58
  %247 = or i64 %246, %245, !dbg !58
  store i64 %247, i64* %4, align 8, !dbg !58
  store i64 0, i64* %4, align 8, !dbg !59
  %248 = load i32, i32* %2, align 4, !dbg !60
  %249 = sub nsw i32 %248, 1, !dbg !60
  %250 = icmp sge i32 %249, 0, !dbg !60
  br i1 %250, label %251, label %272, !dbg !60

251:                                              ; preds = %244
  %252 = load i32, i32* %2, align 4, !dbg !60
  %253 = sub nsw i32 %252, 1, !dbg !60
  %254 = icmp sle i32 %253, 7, !dbg !60
  br i1 %254, label %255, label %272, !dbg !60

255:                                              ; preds = %251
  %256 = load i32, i32* %3, align 4, !dbg !60
  %257 = sub nsw i32 %256, 1, !dbg !60
  %258 = icmp sge i32 %257, 0, !dbg !60
  br i1 %258, label %259, label %272, !dbg !60

259:                                              ; preds = %255
  %260 = load i32, i32* %3, align 4, !dbg !60
  %261 = sub nsw i32 %260, 1, !dbg !60
  %262 = icmp sle i32 %261, 7, !dbg !60
  br i1 %262, label %263, label %272, !dbg !60

263:                                              ; preds = %259
  %264 = load i32, i32* %2, align 4, !dbg !60
  %265 = sub nsw i32 %264, 1, !dbg !60
  %266 = mul nsw i32 %265, 8, !dbg !60
  %267 = load i32, i32* %3, align 4, !dbg !60
  %268 = sub nsw i32 %267, 1, !dbg !60
  %269 = add nsw i32 %266, %268, !dbg !60
  %270 = zext i32 %269 to i64, !dbg !60
  call void @klee_overshift_check(i64 64, i64 %270), !dbg !60
  %271 = shl i64 1, %270, !dbg !60, !klee.check.shift !43
  br label %273, !dbg !60

272:                                              ; preds = %259, %255, %251, %244
  br label %273, !dbg !60

273:                                              ; preds = %272, %263
  %274 = phi i64 [ %271, %263 ], [ 0, %272 ], !dbg !60
  %275 = load i64, i64* %4, align 8, !dbg !61
  %276 = or i64 %275, %274, !dbg !61
  store i64 %276, i64* %4, align 8, !dbg !61
  %277 = load i32, i32* %2, align 4, !dbg !62
  %278 = sub nsw i32 %277, 1, !dbg !62
  %279 = icmp sge i32 %278, 0, !dbg !62
  br i1 %279, label %280, label %298, !dbg !62

280:                                              ; preds = %273
  %281 = load i32, i32* %2, align 4, !dbg !62
  %282 = sub nsw i32 %281, 1, !dbg !62
  %283 = icmp sle i32 %282, 7, !dbg !62
  br i1 %283, label %284, label %298, !dbg !62

284:                                              ; preds = %280
  %285 = load i32, i32* %3, align 4, !dbg !62
  %286 = icmp sge i32 %285, 0, !dbg !62
  br i1 %286, label %287, label %298, !dbg !62

287:                                              ; preds = %284
  %288 = load i32, i32* %3, align 4, !dbg !62
  %289 = icmp sle i32 %288, 7, !dbg !62
  br i1 %289, label %290, label %298, !dbg !62

290:                                              ; preds = %287
  %291 = load i32, i32* %2, align 4, !dbg !62
  %292 = sub nsw i32 %291, 1, !dbg !62
  %293 = mul nsw i32 %292, 8, !dbg !62
  %294 = load i32, i32* %3, align 4, !dbg !62
  %295 = add nsw i32 %293, %294, !dbg !62
  %296 = zext i32 %295 to i64, !dbg !62
  call void @klee_overshift_check(i64 64, i64 %296), !dbg !62
  %297 = shl i64 1, %296, !dbg !62, !klee.check.shift !43
  br label %299, !dbg !62

298:                                              ; preds = %287, %284, %280, %273
  br label %299, !dbg !62

299:                                              ; preds = %298, %290
  %300 = phi i64 [ %297, %290 ], [ 0, %298 ], !dbg !62
  %301 = load i64, i64* %4, align 8, !dbg !63
  %302 = or i64 %301, %300, !dbg !63
  store i64 %302, i64* %4, align 8, !dbg !63
  %303 = load i32, i32* %2, align 4, !dbg !64
  %304 = sub nsw i32 %303, 1, !dbg !64
  %305 = icmp sge i32 %304, 0, !dbg !64
  br i1 %305, label %306, label %327, !dbg !64

306:                                              ; preds = %299
  %307 = load i32, i32* %2, align 4, !dbg !64
  %308 = sub nsw i32 %307, 1, !dbg !64
  %309 = icmp sle i32 %308, 7, !dbg !64
  br i1 %309, label %310, label %327, !dbg !64

310:                                              ; preds = %306
  %311 = load i32, i32* %3, align 4, !dbg !64
  %312 = add nsw i32 %311, 1, !dbg !64
  %313 = icmp sge i32 %312, 0, !dbg !64
  br i1 %313, label %314, label %327, !dbg !64

314:                                              ; preds = %310
  %315 = load i32, i32* %3, align 4, !dbg !64
  %316 = add nsw i32 %315, 1, !dbg !64
  %317 = icmp sle i32 %316, 7, !dbg !64
  br i1 %317, label %318, label %327, !dbg !64

318:                                              ; preds = %314
  %319 = load i32, i32* %2, align 4, !dbg !64
  %320 = sub nsw i32 %319, 1, !dbg !64
  %321 = mul nsw i32 %320, 8, !dbg !64
  %322 = load i32, i32* %3, align 4, !dbg !64
  %323 = add nsw i32 %322, 1, !dbg !64
  %324 = add nsw i32 %321, %323, !dbg !64
  %325 = zext i32 %324 to i64, !dbg !64
  call void @klee_overshift_check(i64 64, i64 %325), !dbg !64
  %326 = shl i64 1, %325, !dbg !64, !klee.check.shift !43
  br label %328, !dbg !64

327:                                              ; preds = %314, %310, %306, %299
  br label %328, !dbg !64

328:                                              ; preds = %327, %318
  %329 = phi i64 [ %326, %318 ], [ 0, %327 ], !dbg !64
  %330 = load i64, i64* %4, align 8, !dbg !65
  %331 = or i64 %330, %329, !dbg !65
  store i64 %331, i64* %4, align 8, !dbg !65
  %332 = load i64, i64* %4, align 8, !dbg !66
  %333 = load i32, i32* %2, align 4, !dbg !67
  %334 = load i32, i32* %3, align 4, !dbg !68
  %335 = sub nsw i32 %334, 1, !dbg !69
  %336 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.1, i64 0, i64 0), i64 %332, i32 %333, i32 %335), !dbg !70
  %337 = load i32, i32* %2, align 4, !dbg !71
  %338 = icmp sge i32 %337, 0, !dbg !73
  br i1 %338, label %339, label %357, !dbg !74

339:                                              ; preds = %328
  %340 = load i32, i32* %2, align 4, !dbg !75
  %341 = icmp sle i32 %340, 7, !dbg !76
  br i1 %341, label %342, label %357, !dbg !77

342:                                              ; preds = %339
  %343 = load i32, i32* %3, align 4, !dbg !78
  %344 = sub nsw i32 %343, 1, !dbg !79
  %345 = icmp sge i32 %344, 0, !dbg !80
  br i1 %345, label %346, label %357, !dbg !81

346:                                              ; preds = %342
  %347 = load i32, i32* %3, align 4, !dbg !82
  %348 = sub nsw i32 %347, 1, !dbg !83
  %349 = icmp sle i32 %348, 7, !dbg !84
  br i1 %349, label %350, label %357, !dbg !85

350:                                              ; preds = %346
  %351 = load i32, i32* %2, align 4, !dbg !86
  %352 = mul nsw i32 %351, 8, !dbg !87
  %353 = load i32, i32* %3, align 4, !dbg !88
  %354 = sub nsw i32 %353, 1, !dbg !89
  %355 = add nsw i32 %352, %354, !dbg !90
  %356 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.2, i64 0, i64 0), i32 %355), !dbg !91
  br label %357, !dbg !91

357:                                              ; preds = %350, %346, %342, %339, %328
  %358 = load i32, i32* %2, align 4, !dbg !92
  %359 = icmp sge i32 %358, 0, !dbg !92
  br i1 %359, label %360, label %379, !dbg !92

360:                                              ; preds = %357
  %361 = load i32, i32* %2, align 4, !dbg !92
  %362 = icmp sle i32 %361, 7, !dbg !92
  br i1 %362, label %363, label %379, !dbg !92

363:                                              ; preds = %360
  %364 = load i32, i32* %3, align 4, !dbg !92
  %365 = sub nsw i32 %364, 1, !dbg !92
  %366 = icmp sge i32 %365, 0, !dbg !92
  br i1 %366, label %367, label %379, !dbg !92

367:                                              ; preds = %363
  %368 = load i32, i32* %3, align 4, !dbg !92
  %369 = sub nsw i32 %368, 1, !dbg !92
  %370 = icmp sle i32 %369, 7, !dbg !92
  br i1 %370, label %371, label %379, !dbg !92

371:                                              ; preds = %367
  %372 = load i32, i32* %2, align 4, !dbg !92
  %373 = mul nsw i32 %372, 8, !dbg !92
  %374 = load i32, i32* %3, align 4, !dbg !92
  %375 = sub nsw i32 %374, 1, !dbg !92
  %376 = add nsw i32 %373, %375, !dbg !92
  %377 = zext i32 %376 to i64, !dbg !92
  call void @klee_overshift_check(i64 64, i64 %377), !dbg !92
  %378 = shl i64 1, %377, !dbg !92, !klee.check.shift !43
  br label %380, !dbg !92

379:                                              ; preds = %367, %363, %360, %357
  br label %380, !dbg !92

380:                                              ; preds = %379, %371
  %381 = phi i64 [ %378, %371 ], [ 0, %379 ], !dbg !92
  %382 = load i64, i64* %4, align 8, !dbg !93
  %383 = or i64 %382, %381, !dbg !93
  store i64 %383, i64* %4, align 8, !dbg !93
  %384 = load i32, i32* %2, align 4, !dbg !94
  %385 = icmp sge i32 %384, 0, !dbg !94
  br i1 %385, label %386, label %405, !dbg !94

386:                                              ; preds = %380
  %387 = load i32, i32* %2, align 4, !dbg !94
  %388 = icmp sle i32 %387, 7, !dbg !94
  br i1 %388, label %389, label %405, !dbg !94

389:                                              ; preds = %386
  %390 = load i32, i32* %3, align 4, !dbg !94
  %391 = add nsw i32 %390, 1, !dbg !94
  %392 = icmp sge i32 %391, 0, !dbg !94
  br i1 %392, label %393, label %405, !dbg !94

393:                                              ; preds = %389
  %394 = load i32, i32* %3, align 4, !dbg !94
  %395 = add nsw i32 %394, 1, !dbg !94
  %396 = icmp sle i32 %395, 7, !dbg !94
  br i1 %396, label %397, label %405, !dbg !94

397:                                              ; preds = %393
  %398 = load i32, i32* %2, align 4, !dbg !94
  %399 = mul nsw i32 %398, 8, !dbg !94
  %400 = load i32, i32* %3, align 4, !dbg !94
  %401 = add nsw i32 %400, 1, !dbg !94
  %402 = add nsw i32 %399, %401, !dbg !94
  %403 = zext i32 %402 to i64, !dbg !94
  call void @klee_overshift_check(i64 64, i64 %403), !dbg !94
  %404 = shl i64 1, %403, !dbg !94, !klee.check.shift !43
  br label %406, !dbg !94

405:                                              ; preds = %393, %389, %386, %380
  br label %406, !dbg !94

406:                                              ; preds = %405, %397
  %407 = phi i64 [ %404, %397 ], [ 0, %405 ], !dbg !94
  %408 = load i64, i64* %4, align 8, !dbg !95
  %409 = or i64 %408, %407, !dbg !95
  store i64 %409, i64* %4, align 8, !dbg !95
  %410 = load i32, i32* %2, align 4, !dbg !96
  %411 = add nsw i32 %410, 1, !dbg !96
  %412 = icmp sge i32 %411, 0, !dbg !96
  br i1 %412, label %413, label %434, !dbg !96

413:                                              ; preds = %406
  %414 = load i32, i32* %2, align 4, !dbg !96
  %415 = add nsw i32 %414, 1, !dbg !96
  %416 = icmp sle i32 %415, 7, !dbg !96
  br i1 %416, label %417, label %434, !dbg !96

417:                                              ; preds = %413
  %418 = load i32, i32* %3, align 4, !dbg !96
  %419 = sub nsw i32 %418, 1, !dbg !96
  %420 = icmp sge i32 %419, 0, !dbg !96
  br i1 %420, label %421, label %434, !dbg !96

421:                                              ; preds = %417
  %422 = load i32, i32* %3, align 4, !dbg !96
  %423 = sub nsw i32 %422, 1, !dbg !96
  %424 = icmp sle i32 %423, 7, !dbg !96
  br i1 %424, label %425, label %434, !dbg !96

425:                                              ; preds = %421
  %426 = load i32, i32* %2, align 4, !dbg !96
  %427 = add nsw i32 %426, 1, !dbg !96
  %428 = mul nsw i32 %427, 8, !dbg !96
  %429 = load i32, i32* %3, align 4, !dbg !96
  %430 = sub nsw i32 %429, 1, !dbg !96
  %431 = add nsw i32 %428, %430, !dbg !96
  %432 = zext i32 %431 to i64, !dbg !96
  call void @klee_overshift_check(i64 64, i64 %432), !dbg !96
  %433 = shl i64 1, %432, !dbg !96, !klee.check.shift !43
  br label %435, !dbg !96

434:                                              ; preds = %421, %417, %413, %406
  br label %435, !dbg !96

435:                                              ; preds = %434, %425
  %436 = phi i64 [ %433, %425 ], [ 0, %434 ], !dbg !96
  %437 = load i64, i64* %4, align 8, !dbg !97
  %438 = or i64 %437, %436, !dbg !97
  store i64 %438, i64* %4, align 8, !dbg !97
  %439 = load i32, i32* %2, align 4, !dbg !98
  %440 = add nsw i32 %439, 1, !dbg !98
  %441 = icmp sge i32 %440, 0, !dbg !98
  br i1 %441, label %442, label %460, !dbg !98

442:                                              ; preds = %435
  %443 = load i32, i32* %2, align 4, !dbg !98
  %444 = add nsw i32 %443, 1, !dbg !98
  %445 = icmp sle i32 %444, 7, !dbg !98
  br i1 %445, label %446, label %460, !dbg !98

446:                                              ; preds = %442
  %447 = load i32, i32* %3, align 4, !dbg !98
  %448 = icmp sge i32 %447, 0, !dbg !98
  br i1 %448, label %449, label %460, !dbg !98

449:                                              ; preds = %446
  %450 = load i32, i32* %3, align 4, !dbg !98
  %451 = icmp sle i32 %450, 7, !dbg !98
  br i1 %451, label %452, label %460, !dbg !98

452:                                              ; preds = %449
  %453 = load i32, i32* %2, align 4, !dbg !98
  %454 = add nsw i32 %453, 1, !dbg !98
  %455 = mul nsw i32 %454, 8, !dbg !98
  %456 = load i32, i32* %3, align 4, !dbg !98
  %457 = add nsw i32 %455, %456, !dbg !98
  %458 = zext i32 %457 to i64, !dbg !98
  call void @klee_overshift_check(i64 64, i64 %458), !dbg !98
  %459 = shl i64 1, %458, !dbg !98, !klee.check.shift !43
  br label %461, !dbg !98

460:                                              ; preds = %449, %446, %442, %435
  br label %461, !dbg !98

461:                                              ; preds = %460, %452
  %462 = phi i64 [ %459, %452 ], [ 0, %460 ], !dbg !98
  %463 = load i64, i64* %4, align 8, !dbg !99
  %464 = or i64 %463, %462, !dbg !99
  store i64 %464, i64* %4, align 8, !dbg !99
  %465 = load i32, i32* %2, align 4, !dbg !100
  %466 = add nsw i32 %465, 1, !dbg !100
  %467 = icmp sge i32 %466, 0, !dbg !100
  br i1 %467, label %468, label %489, !dbg !100

468:                                              ; preds = %461
  %469 = load i32, i32* %2, align 4, !dbg !100
  %470 = add nsw i32 %469, 1, !dbg !100
  %471 = icmp sle i32 %470, 7, !dbg !100
  br i1 %471, label %472, label %489, !dbg !100

472:                                              ; preds = %468
  %473 = load i32, i32* %3, align 4, !dbg !100
  %474 = add nsw i32 %473, 1, !dbg !100
  %475 = icmp sge i32 %474, 0, !dbg !100
  br i1 %475, label %476, label %489, !dbg !100

476:                                              ; preds = %472
  %477 = load i32, i32* %3, align 4, !dbg !100
  %478 = add nsw i32 %477, 1, !dbg !100
  %479 = icmp sle i32 %478, 7, !dbg !100
  br i1 %479, label %480, label %489, !dbg !100

480:                                              ; preds = %476
  %481 = load i32, i32* %2, align 4, !dbg !100
  %482 = add nsw i32 %481, 1, !dbg !100
  %483 = mul nsw i32 %482, 8, !dbg !100
  %484 = load i32, i32* %3, align 4, !dbg !100
  %485 = add nsw i32 %484, 1, !dbg !100
  %486 = add nsw i32 %483, %485, !dbg !100
  %487 = zext i32 %486 to i64, !dbg !100
  call void @klee_overshift_check(i64 64, i64 %487), !dbg !100
  %488 = shl i64 1, %487, !dbg !100, !klee.check.shift !43
  br label %490, !dbg !100

489:                                              ; preds = %476, %472, %468, %461
  br label %490, !dbg !100

490:                                              ; preds = %489, %480
  %491 = phi i64 [ %488, %480 ], [ 0, %489 ], !dbg !100
  %492 = load i64, i64* %4, align 8, !dbg !101
  %493 = or i64 %492, %491, !dbg !101
  store i64 %493, i64* %4, align 8, !dbg !101
  br label %494, !dbg !102

494:                                              ; preds = %490
  %495 = load i32, i32* %3, align 4, !dbg !103
  %496 = add nsw i32 %495, 1, !dbg !103
  store i32 %496, i32* %3, align 4, !dbg !103
  br label %9, !dbg !104, !llvm.loop !105

497:                                              ; preds = %9
  br label %498, !dbg !106

498:                                              ; preds = %497
  %499 = load i32, i32* %2, align 4, !dbg !107
  %500 = add nsw i32 %499, 1, !dbg !107
  store i32 %500, i32* %2, align 4, !dbg !107
  br label %5, !dbg !108, !llvm.loop !109

501:                                              ; preds = %5
  %502 = load i32, i32* %1, align 4, !dbg !111
  ret i32 %502, !dbg !111
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @klee_overshift_check(i64, i64) #3 !dbg !112 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  call void @llvm.dbg.declare(metadata i64* %3, metadata !117, metadata !DIExpression()), !dbg !118
  store i64 %1, i64* %4, align 8
  call void @llvm.dbg.declare(metadata i64* %4, metadata !119, metadata !DIExpression()), !dbg !120
  %5 = load i64, i64* %4, align 8, !dbg !121
  %6 = load i64, i64* %3, align 8, !dbg !123
  %7 = icmp uge i64 %5, %6, !dbg !124
  br i1 %7, label %8, label %9, !dbg !125

8:                                                ; preds = %2
  call void @klee_report_error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1.4, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.2.5, i64 0, i64 0)) #5, !dbg !126
  unreachable, !dbg !126

9:                                                ; preds = %2
  ret void, !dbg !128
}

; Function Attrs: noreturn
declare dso_local void @klee_report_error(i8*, i32, i8*, i8*) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn }

!llvm.dbg.cu = !{!0, !3}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/home/beverly/Documents/klee/examples/BIT-shift")
!2 = !{}
!3 = distinct !DICompileUnit(language: DW_LANG_C89, file: !4, producer: "clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!4 = !DIFile(filename: "/home/beverly/Documents/klee/runtime/Intrinsic/klee_overshift_check.c", directory: "/home/beverly/Documents/klee/build/runtime/Intrinsic")
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !10, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "r", scope: !9, file: !1, line: 9, type: !12)
!14 = !DILocation(line: 9, column: 9, scope: !9)
!15 = !DILocalVariable(name: "c", scope: !9, file: !1, line: 9, type: !12)
!16 = !DILocation(line: 9, column: 12, scope: !9)
!17 = !DILocation(line: 18, column: 12, scope: !18)
!18 = distinct !DILexicalBlock(scope: !9, file: !1, line: 18, column: 5)
!19 = !DILocation(line: 18, column: 10, scope: !18)
!20 = !DILocation(line: 18, column: 17, scope: !21)
!21 = distinct !DILexicalBlock(scope: !18, file: !1, line: 18, column: 5)
!22 = !DILocation(line: 18, column: 19, scope: !21)
!23 = !DILocation(line: 18, column: 5, scope: !18)
!24 = !DILocation(line: 19, column: 12, scope: !25)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 19, column: 5)
!26 = !DILocation(line: 19, column: 10, scope: !25)
!27 = !DILocation(line: 19, column: 17, scope: !28)
!28 = distinct !DILexicalBlock(scope: !25, file: !1, line: 19, column: 5)
!29 = !DILocation(line: 19, column: 19, scope: !28)
!30 = !DILocation(line: 19, column: 5, scope: !25)
!31 = !DILocation(line: 21, column: 37, scope: !32)
!32 = distinct !DILexicalBlock(scope: !28, file: !1, line: 20, column: 5)
!33 = !DILocation(line: 21, column: 40, scope: !32)
!34 = !DILocation(line: 21, column: 9, scope: !32)
!35 = !DILocalVariable(name: "moves", scope: !32, file: !1, line: 27, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !37, line: 27, baseType: !38)
!37 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !39, line: 43, baseType: !40)
!39 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!40 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!41 = !DILocation(line: 27, column: 17, scope: !32)
!42 = !DILocation(line: 29, column: 18, scope: !32)
!43 = !{!"True"}
!44 = !DILocation(line: 29, column: 15, scope: !32)
!45 = !DILocation(line: 30, column: 18, scope: !32)
!46 = !DILocation(line: 30, column: 15, scope: !32)
!47 = !DILocation(line: 31, column: 18, scope: !32)
!48 = !DILocation(line: 31, column: 15, scope: !32)
!49 = !DILocation(line: 32, column: 18, scope: !32)
!50 = !DILocation(line: 32, column: 15, scope: !32)
!51 = !DILocation(line: 33, column: 18, scope: !32)
!52 = !DILocation(line: 33, column: 15, scope: !32)
!53 = !DILocation(line: 34, column: 18, scope: !32)
!54 = !DILocation(line: 34, column: 15, scope: !32)
!55 = !DILocation(line: 35, column: 18, scope: !32)
!56 = !DILocation(line: 35, column: 15, scope: !32)
!57 = !DILocation(line: 36, column: 18, scope: !32)
!58 = !DILocation(line: 36, column: 15, scope: !32)
!59 = !DILocation(line: 40, column: 15, scope: !32)
!60 = !DILocation(line: 41, column: 18, scope: !32)
!61 = !DILocation(line: 41, column: 15, scope: !32)
!62 = !DILocation(line: 42, column: 18, scope: !32)
!63 = !DILocation(line: 42, column: 15, scope: !32)
!64 = !DILocation(line: 43, column: 18, scope: !32)
!65 = !DILocation(line: 43, column: 15, scope: !32)
!66 = !DILocation(line: 45, column: 51, scope: !32)
!67 = !DILocation(line: 45, column: 58, scope: !32)
!68 = !DILocation(line: 45, column: 61, scope: !32)
!69 = !DILocation(line: 45, column: 62, scope: !32)
!70 = !DILocation(line: 45, column: 9, scope: !32)
!71 = !DILocation(line: 46, column: 13, scope: !72)
!72 = distinct !DILexicalBlock(scope: !32, file: !1, line: 46, column: 13)
!73 = !DILocation(line: 46, column: 15, scope: !72)
!74 = !DILocation(line: 46, column: 20, scope: !72)
!75 = !DILocation(line: 46, column: 23, scope: !72)
!76 = !DILocation(line: 46, column: 25, scope: !72)
!77 = !DILocation(line: 46, column: 30, scope: !72)
!78 = !DILocation(line: 46, column: 34, scope: !72)
!79 = !DILocation(line: 46, column: 35, scope: !72)
!80 = !DILocation(line: 46, column: 39, scope: !72)
!81 = !DILocation(line: 46, column: 44, scope: !72)
!82 = !DILocation(line: 46, column: 48, scope: !72)
!83 = !DILocation(line: 46, column: 49, scope: !72)
!84 = !DILocation(line: 46, column: 53, scope: !72)
!85 = !DILocation(line: 46, column: 13, scope: !32)
!86 = !DILocation(line: 47, column: 54, scope: !72)
!87 = !DILocation(line: 47, column: 57, scope: !72)
!88 = !DILocation(line: 47, column: 64, scope: !72)
!89 = !DILocation(line: 47, column: 65, scope: !72)
!90 = !DILocation(line: 47, column: 61, scope: !72)
!91 = !DILocation(line: 47, column: 13, scope: !72)
!92 = !DILocation(line: 49, column: 18, scope: !32)
!93 = !DILocation(line: 49, column: 15, scope: !32)
!94 = !DILocation(line: 50, column: 18, scope: !32)
!95 = !DILocation(line: 50, column: 15, scope: !32)
!96 = !DILocation(line: 51, column: 18, scope: !32)
!97 = !DILocation(line: 51, column: 15, scope: !32)
!98 = !DILocation(line: 52, column: 18, scope: !32)
!99 = !DILocation(line: 52, column: 15, scope: !32)
!100 = !DILocation(line: 53, column: 18, scope: !32)
!101 = !DILocation(line: 53, column: 15, scope: !32)
!102 = !DILocation(line: 56, column: 5, scope: !32)
!103 = !DILocation(line: 19, column: 25, scope: !28)
!104 = !DILocation(line: 19, column: 5, scope: !28)
!105 = distinct !{!105, !30, !106}
!106 = !DILocation(line: 56, column: 5, scope: !25)
!107 = !DILocation(line: 18, column: 25, scope: !21)
!108 = !DILocation(line: 18, column: 5, scope: !21)
!109 = distinct !{!109, !23, !110}
!110 = !DILocation(line: 56, column: 5, scope: !18)
!111 = !DILocation(line: 58, column: 1, scope: !9)
!112 = distinct !DISubprogram(name: "klee_overshift_check", scope: !113, file: !113, line: 20, type: !114, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !3, retainedNodes: !2)
!113 = !DIFile(filename: "runtime/Intrinsic/klee_overshift_check.c", directory: "/home/beverly/Documents/klee")
!114 = !DISubroutineType(types: !115)
!115 = !{null, !116, !116}
!116 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!117 = !DILocalVariable(name: "bitWidth", arg: 1, scope: !112, file: !113, line: 20, type: !116)
!118 = !DILocation(line: 20, column: 46, scope: !112)
!119 = !DILocalVariable(name: "shift", arg: 2, scope: !112, file: !113, line: 20, type: !116)
!120 = !DILocation(line: 20, column: 75, scope: !112)
!121 = !DILocation(line: 21, column: 7, scope: !122)
!122 = distinct !DILexicalBlock(scope: !112, file: !113, line: 21, column: 7)
!123 = !DILocation(line: 21, column: 16, scope: !122)
!124 = !DILocation(line: 21, column: 13, scope: !122)
!125 = !DILocation(line: 21, column: 7, scope: !112)
!126 = !DILocation(line: 27, column: 5, scope: !127)
!127 = distinct !DILexicalBlock(scope: !122, file: !113, line: 21, column: 26)
!128 = !DILocation(line: 29, column: 1, scope: !112)
